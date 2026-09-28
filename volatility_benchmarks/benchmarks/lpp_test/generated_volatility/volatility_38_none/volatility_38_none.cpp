// Generated volatility benchmark
// Case: 38
// Volatility split: none
// Expected classification: none


// ----------------------
// Initialization
// ----------------------
#include <iostream>
#include <string>
//#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cmath>
#include <chrono>
#include <cstring>
#include <algorithm>
#include <omp.h>
#include <cassert>
#include <type_traits>



size_t bg_global_seed = 0;        
size_t bg_global_overflow_length = 1;

template<typename T>
struct bg_array {
    T* data = nullptr;
    T* raw_data = nullptr;
    size_t size = 0;
    T& operator[](long long idx) {
        assert(size > 0 && "bg_array: access on a zero-size array");
        assert(data - raw_data > omp_get_num_threads() && "bg_array: Num threads bigger than reserved overflow area.");
        if (size == 0 || idx < 0 || static_cast<size_t>(idx) >= size) {
            size_t overflow_idx = omp_get_thread_num();
            return raw_data[overflow_idx];
        }
        return data[idx];
    }
    bg_array(size_t length, int seed): size(length) {        
        size_t overflow_length = bg_global_overflow_length;
        raw_data = new T[length + overflow_length];
        data = raw_data + overflow_length;
        for (int i = 0; i < length + overflow_length; i++) {
            uint32_t s=  (seed ^ bg_global_seed) + i;
            uint32_t h = 5381;
            for (int k = 3; k >= 0; k--){               
                h ^= (s >> (8 * k)) & 255;
                h += (h << 5);  
            }
            h ^= (h << 5);  
            if (std::is_floating_point<T>::value){
                raw_data[i] = static_cast<T>(h & 0x1FFFF) * static_cast<T>(0.01);
            } else {
                raw_data[i] = h & 0x3FFF;
            }
        }
    }
    ~bg_array() {
        if (raw_data != nullptr) {
            delete[] raw_data;
        }
    }
};



// ---------------------- 
// Main
// ----------------------
int main(int argc, char** argv) 
{
{
  int vol_shared = 0;
  vol_shared = 200;  // Sink
  int vol_pad[1031];
  for (int vol_pad_i = 0; vol_pad_i < 1031; ++vol_pad_i) {
    vol_pad[vol_pad_i] = vol_pad_i;  // Padding
  }
  int vol_consumed = 0;
  vol_consumed = vol_shared + 1;  // Source
  (void) vol_consumed;
}
        
    // ---------------
    // End Function
    // ---------------
    return 0;
}

