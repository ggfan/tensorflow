/* Copyright 2016 The TensorFlow Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/

#ifndef THIRD_PARTY_TENSORFLOW_EXAMPLES_ANDROID_JNI_OBJECT_TRACKING_LOG_STREAMING_H_
#define THIRD_PARTY_TENSORFLOW_EXAMPLES_ANDROID_JNI_OBJECT_TRACKING_LOG_STREAMING_H_

#include <string.h>
#include <string>

#include "common/lib/strings/stringprintf.h"
#include "common/platform/logging.h"

using namespace tensorflow;

namespace tf_tracking {

#define LOGV(...)
#define LOGD(...)
#define LOGI(...) LOG(INFO) << tensorflow::strings::Printf(__VA_ARGS__);
#define LOGW(...) LOG(INFO) << tensorflow::strings::Printf(__VA_ARGS__);
#define LOGE(...) LOG(INFO) << tensorflow::strings::Printf(__VA_ARGS__);

}  // namespace tf_tracking

#endif  // THIRD_PARTY_TENSORFLOW_EXAMPLES_ANDROID_JNI_OBJECT_TRACKING_LOG_STREAMING_H_
