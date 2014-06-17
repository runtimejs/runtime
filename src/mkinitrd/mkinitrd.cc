// Copyright 2014 Runtime.JS project authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <dirent.h>

#include <cstring>
#include <vector>
#include <string>

#include <common/package.h>

using namespace package;

class PackageFileWriter : public PackageWriter {
public:
    PackageFileWriter(const char* filename)
        :	f_(nullptr),
            error_(false) {
        f_ = fopen(filename, "wb");
        if (nullptr == f_) {
            error_ = true;
            return;
        }
    }

    bool IsError() const {
        return error_;
    }

    ~PackageFileWriter() {
        if (nullptr == f_) return;
        fclose(f_);
    }

    void WriteData(const void* buf, size_t len) {
        if (nullptr == f_) return;
        fwrite(buf, len, 1, f_);
    }
private:
    FILE* f_;
    bool error_;
};

const char* ReadStdin(char* buffer, size_t max_len) {
    char* result = fgets(buffer, max_len, stdin);
    if (nullptr == result) {
        return nullptr;
    }

    size_t len = strlen(buffer);
    if (0 == len) {
        return nullptr;
    }

    if ('\n' == buffer[len - 1]) {
        buffer[len - 1] = '\0';
    }

    void* res = malloc(len + 1);
    memcpy(res, buffer, len);
    char* rc = reinterpret_cast<char*>(res);
    rc[len] = '\0';
    return rc;
}

std::vector<const char*> ReadFiles() {
    std::vector<const char*> files;
    const size_t max_len = 1024;

    char buffer[max_len];
    const char* result = nullptr;

    while ((result = ReadStdin(buffer, max_len))) {
        if (nullptr == result) break;
        files.push_back(result);
        result = nullptr;
    }

    return files;
}

void ListDir(const char* root, const char *name,
             int level, std::vector<std::string>* files) {
    DIR *dir;
    struct dirent *entry;

    if (!(dir = opendir(name))) return;
    if (!(entry = readdir(dir))) return;

    do {
        char path[1024];
        int len = snprintf(path, sizeof(path)-1, "%s/%s", name, entry->d_name);
        path[len] = 0;

        if (entry->d_type == DT_DIR) {
            if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
                continue;
            }

            ListDir(root, path, level + 1, files);
        } else if (entry->d_type == DT_REG) {
            char* dname = entry->d_name;

            if (0 != strlen(dname) && '.' != dname[0]) {

                files->push_back(std::string(path));
            }
        }
    } while ((entry = readdir(dir)));
    closedir(dir);
}

int PrintUsage() {
    fprintf(stderr, "Usage: mkinitrd [-c|-l] <output> <directory>\n");
    fprintf(stderr, "runtime.js initrd tool\n");
    fprintf(stderr, "\n");
    fprintf(stderr, "Commands:\n");
    fprintf(stderr, "  -c\tcreate initrd file <output> from <directory>\n");
    fprintf(stderr, "  -l\tlist files in <directory>\n");
    return -1;
}

int main(int argc, const char* argv[]) {

    if (argc < 4) {
        return PrintUsage();
    }

    const char* cmd = argv[1];
    const char* filename = argv[2];
    const char* directory = argv[3];

    std::vector<std::string> files;
    ListDir(directory, directory, 0, &files);
    size_t root_len = strlen(directory);

    if (0 == strcmp("-l", cmd)) {
        for (const std::string& file : files) {
            printf("%s\n", &file.c_str()[root_len]);
        }
        return 0;
    }

    if (0 == strcmp("-c", cmd)) {
        PackageFileWriter writer(filename);
        for (const std::string& file : files) {
            FILE* f = fopen(file.c_str(), "rb");
            if (nullptr == f) {
                fprintf(stderr, "mkinitrd: unable to open file '%s'.\n", file.c_str());
                return -1;
            }

            int c;
            std::vector<uint8_t> data;
            data.reserve(1024 * 512);
            while ((c = fgetc(f)) != EOF) {
                uint8_t v = static_cast<uint8_t>(c);
                data.push_back(v);
            }

            if (!feof(f)) {
                fprintf(stderr, "mkinitrd: error reading file '%s'.\n", file.c_str());
                return -1;
            }

            fclose(f);

            writer.AddFileData(PackageFileData(
                std::string(&file.c_str()[root_len]), std::move(data)));
        }

        if (writer.IsError()) {
            fprintf(stderr, "mkinitrd: unable to write file.\n");
            return -1;
        }

        writer.Write();
        return 0;
    }

    return PrintUsage();
}
