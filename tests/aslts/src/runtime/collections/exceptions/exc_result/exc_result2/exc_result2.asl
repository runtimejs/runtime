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
 * Check exceptions on storing
 */

// Run-method
Method(RES5)
{
	Store("TEST: RES5, Exceptions on Result Object processing", Debug)

	// Store
	m689("RES5-m689", 0, 1)

	//CopyObject
	m689("RES5-m689", 1, 1)

	// Increment
	m692(0, 1)

	// Decrement
	m692(1, 1)

	// Store the result of the explicit conversion operators
	m693(0, 1, b676, b677, 0)
	m693(0, 1, b67d, b677, 1)

	// CopyObject the result of the explicit conversion operators
	m693(1, 1, b676, b677, 0)
	m693(1, 1, b67d, b677, 1)

	// Optional storing of the result of the explicit conversion operators
	m693(2, 1, b676, b677, 0)
	m693(2, 1, b67d, b677, 1)

	// Store the result of the normal operators
	m694(0, 1, b676, b677, 0)
	m694(0, 1, b67d, b677, 1)

	// CopyObject the result of the normal operators
	m694(1, 1, b676, b677, 0)
	m694(1, 1, b67d, b677, 1)

	// Optional storing of the result of the normal operators
	m694(2, 1, b676, b677, 0)
	m694(2, 1, b67d, b677, 1)
}

