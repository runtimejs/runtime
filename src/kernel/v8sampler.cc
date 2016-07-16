#include "src/libsampler/v8-sampler.h"
#include <kernel/kernel.h>

namespace v8 {
namespace sampler {

Sampler::Sampler(Isolate* isolate)
  : is_counting_samples_(false),
    js_sample_count_(0),
    external_sample_count_(0),
    isolate_(isolate),
    profiling_(false),
    has_processing_thread_(false),
    active_(false),
    registered_(false) {}

Sampler::~Sampler() {}

void Sampler::Start() { RT_ASSERT(!"not implemented"); }
void Sampler::Stop() { RT_ASSERT(!"not implemented"); }
void Sampler::IncreaseProfilingDepth() { RT_ASSERT(!"not implemented"); }
void Sampler::DecreaseProfilingDepth() { RT_ASSERT(!"not implemented"); }
void Sampler::DoSample() { RT_ASSERT(!"not implemented"); }

void Sampler::SetUp() {}
void Sampler::TearDown() {}

}  // namespace sampler
}  // namespace v8
