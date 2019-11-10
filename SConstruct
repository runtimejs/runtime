import os
import sys
import datetime

SetOption('num_jobs', 4)

build = os.getenv('RUNTIME_BUILD', "debug")
print('Build', build)

config = {
    "project_name": "out/runtimejs",
    "binary_output_file": "disk/boot/runtime",
    "toolchain_bin_path": "",
    "fasm_pathname": "fasm",
    "link_script": "etc/kernel.ld",
    "name_gxx": "x86_64-elf-g++",
    "name_gcc": "x86_64-elf-gcc",
    "name_as": "x86_64-elf-as",
    "name_ld": "x86_64-elf-gcc",
    "name_ar": "x86_64-elf-ar",
    "name_ranlib": "x86_64-elf-ranlib",
    "name_objcopy": "x86_64-elf-objcopy",
    "flags_common": {
        "shared": set([
            '-m64',
            '-ffreestanding',
            '-nostdlib',
            '-mno-red-zone',
            '-mno-mmx',
            '-mno-sse3',
            '-mno-3dnow',
            '-nodefaultlibs',
            '-nostartfiles',
            '-Wall',
            '-Wextra',
            '-Wno-unused',
            '-fno-exceptions',
            '-Wno-unused-parameter',
            '-fdiagnostics-color',
            '-D__runtime_js__',
            '-DRUNTIMEJS_PLATFORM_X64',
        ]),
        "release": set([
        ]),
        "debug": set([
            '-g',
            '-ggdb',
        ]),
    },
    "flags_gxx": {
        "shared": set([
            '-nostdinc++',
            '-std=c++11',
            '-O3',
            '-U__STRICT_ANSI__',
            '-DENABLE_DEBUGGER_SUPPORT',
            '-DENABLE_DISASSEMBLER',
            '-DV8_HOST_ARCH_X64',
            '-DV8_TARGET_ARCH_X64',
            # '-DV8_DEPRECATION_WARNINGS',
            # '-DV8_IMMINENT_DEPRECATION_WARNINGS',
            # '-DVERIFY_HEAP',
            # '-DDEBUG',
            # '-DOBJECT_PRINT',
            # '-DENABLE_EXTRA_CHECKS',
            # '-DENABLE_HANDLE_ZAPPING',
        ]),
        "release": set([
        ]),
        "debug": set([
        ]),
    },
    "flags_gcc": {
        "shared": set([
            '-O2',
            '-c',
            '-std=c99',
            '-D_XOPEN_SOURCE=700',
            '-DSODIUM_STATIC',
        ]),
        "release": set([
        ]),
        "debug": set([
        ]),
    },
    "flags_link": set([
        '-nostdlib',
        '-nodefaultlibs',
        # '-Map etc/map.txt',
    ]),
    "locations": {
        "cc": [
            'src',
            'src/arch',
            'src/kernel',
            'src/kernel/x64',
            'src/kernel/profiler',
            'src/common',
            'test/cc',
        ],
        "asm": [
            'src',
            'src/kernel/x64',
        ],
        "js": [
            'src/kernel/Js',
        ],
    },
    "includes": [
        'deps/musl/src/internal',
        'deps/musl/include',
        'deps/musl/arch/x86_64',
        'deps/musl/arch/x86_64/bits',
        'deps/libcxx/include',
        'deps/v8/include',
        'deps/v8',
        'deps/concurrentqueue',
        'deps/acpica/source/include',
        'deps/printf',
        'deps/miniz',
        'deps/libsodium/src/libsodium/include',
        'deps/json11',
        'src',
        'test',
    ],
    "libs": [
        'v8',
        'cxxrt',
        'cxx',
        'miniz',
        'acpica',
        'printf',
        'sodium',
        'json11',
        'musl',
        'gcc',
    ],
}

def CreateToolchainPath(binpath, name):
    return os.path.join(binpath, name);

def CombineFlagsBuild(name, build):
    return config[name]["shared"] | config[name][build]

def EnvironmentCreate(build):
    gxx = CreateToolchainPath(config["toolchain_bin_path"], config["name_gxx"])
    gcc = CreateToolchainPath(config["toolchain_bin_path"], config["name_gcc"])
    ar = CreateToolchainPath(config["toolchain_bin_path"], config["name_ar"])
    ranlib = CreateToolchainPath(config["toolchain_bin_path"], config["name_ranlib"])
    _as = CreateToolchainPath(config["toolchain_bin_path"], config["name_as"])
    ld = CreateToolchainPath(config["toolchain_bin_path"], config["name_ld"])
    fasm = config["fasm_pathname"]

    flags_shared = CombineFlagsBuild("flags_common", build)
    flags_gxx = flags_shared | CombineFlagsBuild("flags_gxx", build)
    flags_gcc = flags_shared | CombineFlagsBuild("flags_gcc", build)

    proj_name = config["project_name"]

    asm_builder = Builder(
        action = fasm + ' $SOURCE $TARGET >/dev/null',
        single_source = 1,
        suffix = '.asm_o',
        src_suffix = '.asm'
    )

    js_builder = Builder(
        action = 'xxd -i < $SOURCE > $TARGET; echo ",0x00" >> $TARGET',
        single_source = 1,
        suffix = '.js.h',
        src_suffix = '.js'
    )

    env = Environment(
        CXX = gxx,
        CC = gcc,
        AR = ar,
        AS = _as,
        RANLIB = ranlib,
        CXXFLAGS = " ".join(flags_gxx),
        CFLAGS = " ".join(flags_gcc),
        LINK = ld,
        LINKFLAGS = '-T ' + config["link_script"] + ' ' + ' '.join(config["flags_link"]) + ' -o ' + proj_name,
        CXXCOMSTR = 'Build $TARGET',
        LINKCOMSTR = 'Link $TARGET',
        RANLIBCOMSTR = 'Index $TARGET',
        ARCOMSTR = 'Archive $TARGET',
        ENV = {'PATH': os.environ['PATH']},
    )

    env.Append(
        BUILDERS = {
            'asm': asm_builder,
            'js': js_builder,
        }
    )

    return env

def BuildProject(env_base):
    env = env_base.Clone();
    sources = {}
    for ext, dirs in config["locations"].items():
        if ext not in sources:
            sources[ext] = []
        for d in dirs:
            path = os.path.join(d, "*."+ext)
            sources[ext].append(Glob(path))

    obj_asm = [env.asm(i) for i in sources["asm"]]
    env.Depends(obj_asm, Glob('src/*.inc'))

    obj_js = [env.js(i) for i in sources["js"]]

    env.Replace(CPPPATH = config["includes"])
    env.Replace(LIBS = config["libs"])
    env.Replace(LIBPATH = ['deps'])

    version_header = env.Command('src/kernel/version-autogenerated.h', 'package.json',
        'node scripts/update-versions.js')

    proj_name = config["project_name"]
    env.Depends(proj_name, obj_js);
    env.Depends(proj_name, version_header)
    env.Depends(proj_name, config["link_script"])
    output_elf = env.Program(proj_name, sources["cc"] + obj_asm)

    binary_output = config["binary_output_file"]
    objcopy = CreateToolchainPath(config["toolchain_bin_path"], config["name_objcopy"])
    output_bin = env.Command(binary_output, '',
        objcopy + ' -O binary --strip-all --set-section-flags \'.bss\'=alloc,load,contents,data ' +
        proj_name + ' ' + binary_output)
    env.Depends(output_bin, output_elf);
    return

# Build kernel
env_base = EnvironmentCreate(build)
SConscript('deps/SConscript', exports = 'env_base')
BuildProject(env_base)
