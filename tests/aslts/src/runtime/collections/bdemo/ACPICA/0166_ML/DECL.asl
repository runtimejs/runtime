/*
 * Some or all of this work - Copyright (c) 2006 - 2014, Intel Corp.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * Neither the name of Intel Corporation nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * Bug 166:
 *
 * SUMMARY: Releasing memory of the inside Method scopes surrounding Return operation is needed
 *
 * Only, to initiate Return operation from the inside
 * Method scopes surrounding that Return operation (If,
 * While, Switch, etc..)
 */


	Method(mf4f)
	{
	}

	Method(mf50)
	{
		if (0xabcd0001) {
			return (0xabcd0010)
		}
	}

	Method(mf51)
	{
		if (0xabcd0000) {
		if (0xabcd0001) {
			return (0xabcd0010)
		}}
	}

	Method(mf52)
	{
		while (0xabcd0000) {
			return (0xabcd0020)
		}
	}

	Method(mf53)
	{
          mf4f()
          mf50()
          mf51()
          mf52()
          while (0xabcd0000) {
            mf4f()
            mf50()
            mf51()
            mf52()
            if (0xabcd0001) {
              while (0xabcd0002) {
                if (0xabcd0003) {
                  while (0xabcd0004) {
                    if (0xabcd0005) {
                      while (0xabcd0006) {
                        if (0xabcd0007) {
                          mf4f()
                          mf50()
                          mf51()
                          mf52()
                          while (0xabcd0008) {
                            if (0xabcd0009) {
                              while (0xabcd000a) {
                                if (0xabcd000b) {
                                  while (0xabcd000c) {
                                    if (0xabcd000d) {
                                      while (0xabcd000e) {
                                        if (0xabcd000f) {

                                            if (0) {
                                              Store("Impossible 0", Debug)
                                            } else {
                                              if (0xabcd0010) {
                                                  return (0xabcd0030)
                                              }
                                            }
                     }}}}
                     mf4f()
                     mf50()
                     mf51()
                     mf52()
              }}}}
              mf4f()
              mf50()
              mf51()
              mf52()
            }}}}
          }}}}
	}

