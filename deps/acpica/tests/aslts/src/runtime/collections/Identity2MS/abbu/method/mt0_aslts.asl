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
 * Tests to check path names with method type syllables
 */

Name(z170, 170)


Processor(pr7d, 0, 0x000, 0x008)
{
	Name(iy07, 0xabcd0120)
}

/*
 * Test shows maximal supported depth of enclosed method calls on MS
 */
Method(mt00,, Serialized)
{
    Name(ts, "mt00")

    Name(i000, 0)

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                              // OUTC("Number of calls to methods depends on the length of this message!")
                              OUTC("Max")
                              Store(0xabcd0000, i000)
                          }
                          mm0b()
                        }
                        mm0a()
                      }
                      mm09()
                    }
                    mm08()
                  }
                  mm07()
                }
                mm06()
              }
              mm05()
            }
            mm04()
          }
          mm03()
        }
        mm02()
      }
      mm01()
    }

    CH03(ts, z170, 0x100, 0, 0)

    mm00()

    if (LNotEqual(i000, 0xabcd0000)) {
        err(ts, z170, 0x000, 0, 0, i000, 0xabcd0000)
    }

    CH03(ts, z170, 0x101, 0, 0)
}

/*
 * The same as mt00, but contains more depth of enclosed method calls.
 * To be run on ACPICA only.
 */
Method(mt01,, Serialized)
{
    Name(ts, "mt01")

    Name(i000, 0)

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                            Method(mm0c)
                            {
                              Method(mm0d)
                              {
                                Method(mm0e)
                                {
                                  Method(mm0f)
                                  {
                                    Method(mm10)
                                    {
                                      Method(mm11)
                                      {
                                        Method(mm12)
                                        {
                                          Method(mm13)
                                          {
                                            Method(mm14)
                                            {
                                              Method(mm15)
                                              {
                                                Method(mm16)
                                                {
                                                  Method(mm17)
                                                  {
                                                    Method(mm18)
                                                    {
                                                      Method(mm19)
                                                      {
                                                        Method(mm1a)
                                                        {
                                                          Method(mm1b)
                                                          {
                                                            Method(mm1c)
                                                            {
                                                              Method(mm1d)
                                                              {
                                                                Method(mm1e)
                                                                {
                                                                  Method(mm1f)
                                                                  {
                                                                    OUTC("Max")
                                                                    Store(0xabcd0000, i000)
                                                                  }
                                                                  mm1f()
                                                                }
                                                                mm1e()
                                                              }
                                                              mm1d()
                                                            }
                                                            mm1c()
                                                          }
                                                          mm1b()
                                                        }
                                                        mm1a()
                                                      }
                                                      mm19()
                                                    }
                                                    mm18()
                                                  }
                                                  mm17()
                                                }
                                                mm16()
                                              }
                                              mm15()
                                            }
                                            mm14()
                                          }
                                          mm13()
                                        }
                                        mm12()
                                      }
                                      mm11()
                                    }
                                    mm10()
                                  }
                                  mm0f()
                                }
                                mm0e()
                              }
                              mm0d()
                            }
                            mm0c()
                          }
                          mm0b()
                        }
                        mm0a()
                      }
                      mm09()
                    }
                    mm08()
                  }
                  mm07()
                }
                mm06()
              }
              mm05()
            }
            mm04()
          }
          mm03()
        }
        mm02()
      }
      mm01()
    }

    CH03(ts, z170, 0x102, 0, 0)

    mm00()

    if (LNotEqual(i000, 0xabcd0000)) {
        err(ts, z170, 0x001, 0, 0, i000, 0xabcd0000)
    }

    CH03(ts, z170, 0x103, 0, 0)
}

/*
 * Test shows maximal supported depth of enclosed method calls on MS
 */
Method(mt02,, Serialized)
{
    Name(ts, "mt02")

    Name(i000, 0)

    Method(mm00)
    {
      mm01()
    }
    Method(mm01)
    {
      mm02()
    }
    Method(mm02)
    {
      mm03()
    }
    Method(mm03)
    {
      mm04()
    }
    Method(mm04)
    {
      mm05()
    }
    Method(mm05)
    {
      mm06()
    }
    Method(mm06)
    {
      mm07()
    }
    Method(mm07)
    {
      mm08()
    }
    Method(mm08)
    {
      mm09()
    }
    Method(mm09)
    {
      mm0a()
    }
    Method(mm0a)
    {
      mm0b()
    }
    Method(mm0b)
    {
      mm0c()
    }
    Method(mm0c)
    {
      mm0d()
    }
    Method(mm0d)
    {
      mm0e()
    }
    Method(mm0e)
    {
      mm0f()
    }
    Method(mm0f)
    {
      OUTC("Max")
      Store(0xabcd0000, i000)
    }

    CH03(ts, z170, 0x104, 0, 0)

    mm00()

    if (LNotEqual(i000, 0xabcd0000)) {
        err(ts, z170, 0x002, 0, 0, i000, 0xabcd0000)
    }

    CH03(ts, z170, 0x105, 0, 0)
}

/*
 * The same as mt02, but contains more depth of enclosed method calls.
 * To be run on ACPICA only.
 */
Method(mt03,, Serialized)
{
    Name(ts, "mt03")

    Name(i000, 0)

    Method(mm00)
    {
      mm01()
    }
    Method(mm01)
    {
      mm02()
    }
    Method(mm02)
    {
      mm03()
    }
    Method(mm03)
    {
      mm04()
    }
    Method(mm04)
    {
      mm05()
    }
    Method(mm05)
    {
      mm06()
    }
    Method(mm06)
    {
      mm07()
    }
    Method(mm07)
    {
      mm08()
    }
    Method(mm08)
    {
      mm09()
    }
    Method(mm09)
    {
      mm0a()
    }
    Method(mm0a)
    {
      mm0b()
    }
    Method(mm0b)
    {
      mm0c()
    }
    Method(mm0c)
    {
      mm0d()
    }
    Method(mm0d)
    {
      mm0e()
    }
    Method(mm0e)
    {
      mm0f()
    }
    Method(mm0f)
    {
      mm10()
    }
    Method(mm10)
    {
      mm11()
    }
    Method(mm11)
    {
      mm12()
    }
    Method(mm12)
    {
      mm13()
    }
    Method(mm13)
    {
      mm14()
    }
    Method(mm14)
    {
      mm15()
    }
    Method(mm15)
    {
      mm16()
    }
    Method(mm16)
    {
      mm17()
    }
    Method(mm17)
    {
      mm18()
    }
    Method(mm18)
    {
      mm19()
    }
    Method(mm19)
    {
      mm1a()
    }
    Method(mm1a)
    {
      mm1b()
    }
    Method(mm1b)
    {
      mm1c()
    }
    Method(mm1c)
    {
      mm1d()
    }
    Method(mm1d)
    {
      mm1e()
    }
    Method(mm1e)
    {
      mm1f()
    }
    Method(mm1f)
    {
      OUTC("Max")
      Store(0xabcd0000, i000)
    }

    CH03(ts, z170, 0x106, 0, 0)

    mm00()

    if (LNotEqual(i000, 0xabcd0000)) {
        err(ts, z170, 0x003, 0, 0, i000, 0xabcd0000)
    }

    CH03(ts, z170, 0x107, 0, 0)
}

/*
 * Increment object with the name of method in the name path
 */
Method(mt04,, Serialized)
{
    Name(ts, "mt04")

    Device(dz05)
    {
        Name(iy07, 0xabcd0100)
    }

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Increment(\mt04.dz05.iy07)
                    Store (\mt04.dz05.iy07, Local0)
                    OUTC("mt04,   \\mt04.dz05.iy07:")
                    OUTC(Local0)
                    if (LNotEqual(Local0, 0xabcd0109)) {
                      err(ts, z170, 0x004, 0, 0, Local0, 0xabcd0109)
                    }
                    if (LNotEqual(\mt04.dz05.iy07, 0xabcd0109)) {
                      err(ts, z170, 0x005, 0, 0, \mt04.dz05.iy07, 0xabcd0109)
                    }
                  }
                  Increment(\mt04.dz05.iy07)
                  mm07()
                }
                Increment(\mt04.dz05.iy07)
                mm06()
              }
              Increment(\mt04.dz05.iy07)
              mm05()
            }
            Increment(\mt04.dz05.iy07)
            mm04()
          }
          Increment(\mt04.dz05.iy07)
          mm03()
        }
        Increment(\mt04.dz05.iy07)
        mm02()
      }
      Increment(\mt04.dz05.iy07)
      mm01()
    }

    CH03(ts, z170, 0x006, 0, 0)

    Increment(\mt04.dz05.iy07)

    mm00()

    if (LNotEqual(\mt04.dz05.iy07, 0xabcd0109)) {
      err(ts, z170, 0x007, 0, 0, \mt04.dz05.iy07, 0xabcd0109)
    }

    CH03(ts, z170, 0x008, 0, 0)
}

/*
 * The same as mt04, but contains more depth of enclosed method calls.
 * To be run on ACPICA only.
 */
Method(mt05,, Serialized)
{
    Name(ts, "mt05")

    Device(dz05)
    {
        Name(iy07, 0xabcd0200)
    }
    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                            Method(mm0c)
                            {
                              Method(mm0d)
                              {
                                Method(mm0e)
                                {
                                  Method(mm0f)
                                  {
                                    Increment(\mt05.dz05.iy07)
                                    Store (\mt05.dz05.iy07, Local0)
                                    OUTC("mt05,   \\mt05.dz05.iy07:")
                                    OUTC(Local0)
                                    if (LNotEqual(Local0, 0xabcd0211)) {
                                        err(ts, z170, 0x009, 0, 0, Local0, 0xabcd0211)
                                    }
                                    if (LNotEqual(\mt05.dz05.iy07, 0xabcd0211)) {
                                        err(ts, z170, 0x00a, 0, 0, \mt05.dz05.iy07, 0xabcd0211)
                                    }
                                  }
                                  Increment(\mt05.dz05.iy07)
                                  mm0f()
                                }
                                Increment(\mt05.dz05.iy07)
                                mm0e()
                              }
                              Increment(\mt05.dz05.iy07)
                              mm0d()
                            }
                            Increment(\mt05.dz05.iy07)
                            mm0c()
                          }
                          Increment(\mt05.dz05.iy07)
                          mm0b()
                        }
                        Increment(\mt05.dz05.iy07)
                        mm0a()
                      }
                      Increment(\mt05.dz05.iy07)
                      mm09()
                    }
                    Increment(\mt05.dz05.iy07)
                    mm08()
                  }
                  Increment(\mt05.dz05.iy07)
                  mm07()
                }
                Increment(\mt05.dz05.iy07)
                mm06()
              }
              Increment(\mt05.dz05.iy07)
              mm05()
            }
            Increment(\mt05.dz05.iy07)
            mm04()
          }
          Increment(\mt05.dz05.iy07)
          mm03()
        }
        Increment(\mt05.dz05.iy07)
        mm02()
      }
      Increment(\mt05.dz05.iy07)
      mm01()
    }

    CH03(ts, z170, 0x108, 0, 0)

    Increment(\mt05.dz05.iy07)
    mm00()

    if (LNotEqual(\mt05.dz05.iy07, 0xabcd0211)) {
        err(ts, z170, 0x00b, 0, 0, \mt05.dz05.iy07, 0xabcd0211)
    }

    CH03(ts, z170, 0x109, 0, 0)
}

/*
 * Check access to the internal object of method being executed
 * from the point inside the tree of that method being executed
 * but by the method statically declared outside that method.
 */
Method(mt06,, Serialized)
{
    Name(ts, "mt06")

    Device(dz05)
    {
        Name(iy07, 0xabcd0300)
    }

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                            Store (0x11112222, \mt06.dz05.iy07)
                        }
                        mm0a()
                      }
                      mm09()
                    }
                    mm08()
                  }
                  mm07()
                }
                mm06()
              }
              mm05()
              Store (\mt06.dz05.iy07, Local0)
              OUTC("mt06,   \\mt06.dz05.iy07:")
              OUTC(Local0)
              if (LNotEqual(Local0, 0x11112222)) {
                  err(ts, z170, 0x00c, 0, 0, Local0, 0x11112222)
              }
              if (LNotEqual(\mt06.dz05.iy07, 0x11112222)) {
                  err(ts, z170, 0x00d, 0, 0, \mt06.dz05.iy07, 0x11112222)
              }
            }
            mm04()
          }
          mm03()
        }
        mm02()
      }
      mm01()
    }

    CH03(ts, z170, 0x10a, 0, 0)

    mm00()

    mt07()

    if (LNotEqual(\mt06.dz05.iy07, 0x11112222)) {
        err(ts, z170, 0x00e, 0, 0, \mt06.dz05.iy07, 0x11112222)
    }

    CH03(ts, z170, 0x10b, 0, 0)
}

/*
 * Access to the internal object of method mt06
 *
 * Result differs depending on either mt06 is invoked or not.
 * Unfortunately, we can run mt06 and mt07 simultaneously only
 * on the same thread (invocation).
 */
Method(mt07,, Serialized)
{
    Name(ts, "mt07")

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Store (\mt06.dz05.iy07, Local0)
                    OUTC("0 mt07,   \\mt06.dz05.iy07:")
                    OUTC(Local0)
                    if (LNotEqual(Local0, 0x11112222)) {
                        err(ts, z170, 0x00f, 0, 0, Local0, 0x11112222)
                    }
                    if (LNotEqual(\mt06.dz05.iy07, 0x11112222)) {
                        err(ts, z170, 0x010, 0, 0, \mt06.dz05.iy07, 0x11112222)
                    }
                  }
                  mm07()
                }
                mm06()
              }
              mm05()
            }
            mm04()
          }
          mm03()
        }
        mm02()
      }
      mm01()
    }

    CH03(ts, z170, 0x10c, 0, 0)

    mm00()

    Store (\mt06.dz05.iy07, Local0)
    OUTC("1 mt07,   \\mt06.dz05.iy07:")
    OUTC(Local0)
    if (LNotEqual(Local0, 0x11112222)) {
        err(ts, z170, 0x011, 0, 0, Local0, 0x11112222)
    }
    if (LNotEqual(\mt06.dz05.iy07, 0x11112222)) {
        err(ts, z170, 0x012, 0, 0, \mt06.dz05.iy07, 0x11112222)
    }

    CH03(ts, z170, 0x10d, 0, 0)
}

/*
 * The same as mt06, but contains more depth of enclosed method calls.
 * To be run on ACPICA only.
 */
Method(mt08,, Serialized)
{
    Name(ts, "mt08")

    Device(dz05)
    {
        Name(iy07, 0xabcd0400)
    }

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                            Method(mm0c)
                            {
                              Method(mm0d)
                              {
                                Method(mm0e)
                                {
                                  Method(mm0f)
                                  {
                                    Store (0x22223333, \mt08.dz05.iy07)
                                  }
                                  mm0f()
                                }
                                mm0e()
                              }
                              mm0d()
                            }
                            mm0c()
                          }
                          mm0b()
                        }
                        mm0a()
                      }
                      mm09()
                    }
                    mm08()
                    Store (\mt08.dz05.iy07, Local0)
                    OUTC("mt08,   \\mt08.dz05.iy07:")
                    OUTC(Local0)
                    if (LNotEqual(Local0, 0x22223333)) {
                        err(ts, z170, 0x013, 0, 0, Local0, 0x22223333)
                    }
                    if (LNotEqual(\mt08.dz05.iy07, 0x22223333)) {
                        err(ts, z170, 0x014, 0, 0, \mt08.dz05.iy07, 0x22223333)
                    }
                  }
                  mm07()
                }
                mm06()
              }
              mm05()
            }
            mm04()
          }
          mm03()
        }
        mm02()
      }
      mm01()
    }

    CH03(ts, z170, 0x10e, 0, 0)

    mm00()

    mt09()

    if (LNotEqual(\mt08.dz05.iy07, 0x22223333)) {
        err(ts, z170, 0x015, 0, 0, \mt08.dz05.iy07, 0x22223333)
    }

    CH03(ts, z170, 0x10f, 0, 0)
}

/*
 * Access to the internal object of method mt08
 *
 * see comment to mt07
 */
Method(mt09,, Serialized)
{
    Name(ts, "mt09")

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                            Method(mm0c)
                            {
                              Method(mm0d)
                              {
                                Method(mm0e)
                                {
                                  Method(mm0f)
                                  {
                                    Store (\mt08.dz05.iy07, Local0)
                                    OUTC("0 mt09,   \\mt08.dz05.iy07:")
                                    OUTC(Local0)
                                    if (LNotEqual(Local0, 0x22223333)) {
                                        err(ts, z170, 0x016, 0, 0, Local0, 0x22223333)
                                    }
                                    if (LNotEqual(\mt08.dz05.iy07, 0x22223333)) {
                                        err(ts, z170, 0x017, 0, 0, \mt08.dz05.iy07, 0x22223333)
                                    }
                                  }
                                  mm0f()
                                }
                                mm0e()
                              }
                              mm0d()
                            }
                            mm0c()
                          }
                          mm0b()
                        }
                        mm0a()
                      }
                      mm09()
                    }
                    mm08()
                  }
                  mm07()
                }
                mm06()
              }
              mm05()
            }
            mm04()
          }
          mm03()
        }
        mm02()
      }
      mm01()
    }

    CH03(ts, z170, 0x110, 0, 0)

    mm00()

    Store (\mt08.dz05.iy07, Local0)
    OUTC("1 mt09,   \\mt08.dz05.iy07:")
    OUTC(Local0)
    if (LNotEqual(Local0, 0x22223333)) {
        err(ts, z170, 0x018, 0, 0, Local0, 0x22223333)
    }
    if (LNotEqual(\mt08.dz05.iy07, 0x22223333)) {
        err(ts, z170, 0x019, 0, 0, \mt08.dz05.iy07, 0x22223333)
    }

    CH03(ts, z170, 0x111, 0, 0)
}

/*
 * Check simple access to the object by the name path
 * without method name syllables
 */
Method(mt0a,, Serialized)
{
    Name(ts, "mt0a")

    CH03(ts, z170, 0x112, 0, 0)

    Store (\pr7d.iy07, Local0)
    OUTC("mt0a,   \\pr7d.iy07:")
    OUTC(Local0)
    if (LNotEqual(\pr7d.iy07, 0xabcd0120)) {
        err(ts, z170, 0x01a, 0, 0, \pr7d.iy07, 0xabcd0120)
    }

    CH03(ts, z170, 0x113, 0, 0)
}

/*
 * Simple increment (see comment to mt0a)
 */
Method(mt0b,, Serialized)
{
    Name(ts, "mt0b")

    CH03(ts, z170, 0x114, 0, 0)

    Increment(\pr7d.iy07)
    Store (\pr7d.iy07, Local0)
    OUTC("mt0b,   \\pr7d.iy07:")
    OUTC(Local0)

    if (LNotEqual(\pr7d.iy07, 0xabcd0121)) {
        err(ts, z170, 0x01b, 0, 0, \pr7d.iy07, 0xabcd0121)
    }

    CH03(ts, z170, 0x115, 0, 0)
}

/*
 * Check simple access to the object by the name path
 * which contains the method name syllables
 */
Method(mt0c,, Serialized)
{
    Name(ts, "mt0c")

    Processor(pr7d, 0, 0x000, 0x008)
    {
        Name(iy07, 0xabcd0660)
    }

    CH03(ts, z170, 0x116, 0, 0)

    Increment(\mt0c.pr7d.iy07)
    Store (\mt0c.pr7d.iy07, Local0)
    OUTC("mt0c,   \\mt0c.pr7d.iy07:")
    OUTC(Local0)

    if (LNotEqual(\mt0c.pr7d.iy07, 0xabcd0661)) {
        err(ts, z170, 0x01d, 0, 0, \mt0c.pr7d.iy07, 0xabcd0661)
    }

    CH03(ts, z170, 0x117, 0, 0)
}

/*
 * Simply long cycle in While
 */
Method(mt0d,, Serialized)
{
	Name(ts, "mt0d")

	Name(i000, 0xabcd1234)

	CH03(ts, z170, 0x118, 0, 0)

	Store(0, Local0)
	While (1) {
		Increment(Local0)
//		if (LEqual(Local0, 0x40000)) {
		if (LEqual(Local0, 100)) {
			// Break -- doesn't work on MS
			OUTC("mt0d,   Local0:")
			OUTC(Local0)

			mt0e()

			CH03(ts, z170, 0x119, 0, 0)

			Return
		}
	}

	CH03(ts, z170, 0x11a, 0, 0)
}

/*
 * Access to the internal object of method mt0d
 */
Method(mt0e,, Serialized)
{
    Name(ts, "mt0e")

    CH03(ts, z170, 0x11b, 0, 0)

    Store (\mt0d.i000, Local0)
    OUTC("mt0e,   \\mt0d.i000:")
    OUTC(Local0)

    if (LNotEqual(\mt0d.i000, 0xabcd1234)) {
        err(ts, z170, 0x01f, 0, 0, \mt0d.i000, 0xabcd1234)
    }

    CH03(ts, z170, 0x11c, 0, 0)
}

/*
 * Use Add for incrementing object with the
 * name of method in the name path.
 */
Method(mt0f,, Serialized)
{
    Name(ts, "mt0f")

    Device(dz05)
    {
        Name(iy07, 0xabcd0500)
    }

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Add(\mt0f.dz05.iy07, 1, \mt0f.dz05.iy07)
                    Store (\mt0f.dz05.iy07, Local0)
                    OUTC("mt0f,   \\mt0f.dz05.iy07:")
                    OUTC(Local0)
                    if (LNotEqual(Local0, 0xabcd0509)) {
                      err(ts, z170, 0x020, 0, 0, Local0, 0xabcd0509)
                    }
                    if (LNotEqual(\mt0f.dz05.iy07, 0xabcd0509)) {
                      err(ts, z170, 0x021, 0, 0, \mt0f.dz05.iy07, 0xabcd0509)
                    }
                  }
                  Add(\mt0f.dz05.iy07, 1, \mt0f.dz05.iy07)
                  mm07()
                }
                Add(\mt0f.dz05.iy07, 1, \mt0f.dz05.iy07)
                mm06()
              }
              Add(\mt0f.dz05.iy07, 1, \mt0f.dz05.iy07)
              mm05()
            }
            Add(\mt0f.dz05.iy07, 1, \mt0f.dz05.iy07)
            mm04()
          }
          Add(\mt0f.dz05.iy07, 1, \mt0f.dz05.iy07)
          mm03()
        }
        Add(\mt0f.dz05.iy07, 1, \mt0f.dz05.iy07)
        mm02()
      }
      Add(\mt0f.dz05.iy07, 1, \mt0f.dz05.iy07)
      mm01()
    }

    CH03(ts, z170, 0x022, 0, 0)

    Add(\mt0f.dz05.iy07, 1, \mt0f.dz05.iy07)
    mm00()

    if (LNotEqual(\mt0f.dz05.iy07, 0xabcd0509)) {
      err(ts, z170, 0x023, 0, 0, \mt0f.dz05.iy07, 0xabcd0509)
    }

    CH03(ts, z170, 0x024, 0, 0)
}

/*
 * The same as mt0f, but contains more depth of enclosed method calls.
 * To be run on ACPICA only.
 */
Method(mt10,, Serialized)
{
    Name(ts, "mt10")

    Device(dz05)
    {
        Name(iy07, 0xabcd0600)
    }
    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                            Method(mm0c)
                            {
                              Method(mm0d)
                              {
                                Method(mm0e)
                                {
                                  Method(mm0f)
                                  {
                                    Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                                    Store (\mt10.dz05.iy07, Local0)
                                    OUTC("mt10,   \\mt10.dz05.iy07:")
                                    OUTC(Local0)
                                    if (LNotEqual(Local0, 0xabcd0611)) {
                                        err(ts, z170, 0x025, 0, 0, Local0, 0xabcd0611)
                                    }
                                    if (LNotEqual(\mt10.dz05.iy07, 0xabcd0611)) {
                                        err(ts, z170, 0x026, 0, 0, \mt10.dz05.iy07, 0xabcd0611)
                                    }
                                  }
                                  Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                                  mm0f()
                                }
                                Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                                mm0e()
                              }
                              Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                              mm0d()
                            }
                            Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                            mm0c()
                          }
                          Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                          mm0b()
                        }
                        Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                        mm0a()
                      }
                      Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                      mm09()
                    }
                    Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                    mm08()
                  }
                  Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                  mm07()
                }
                Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
                mm06()
              }
              Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
              mm05()
            }
            Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
            mm04()
          }
          Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
          mm03()
        }
        Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
        mm02()
      }
      Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
      mm01()
    }

    CH03(ts, z170, 0x027, 0, 0)

    Add(\mt10.dz05.iy07, 1, \mt10.dz05.iy07)
    mm00()

    if (LNotEqual(\mt10.dz05.iy07, 0xabcd0611)) {
        err(ts, z170, 0x028, 0, 0, \mt10.dz05.iy07, 0xabcd0611)
    }

    CH03(ts, z170, 0x029, 0, 0)
}

/*
 * Increment with the parent name paths
 */
Method(mt11,, Serialized)
{
    Name(ts, "mt11")

    Device(dz05)
    {
        Name(iy07, 0xabcd0700)
    }

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Increment(^^^^^^^^dz05.iy07)
                    Store (^^^^^^^^dz05.iy07, Local0)
                    OUTC("mt11,   ^^^^^^^^dz05.iy07:")
                    OUTC(Local0)
                    if (LNotEqual(Local0, 0xabcd0709)) {
                      err(ts, z170, 0x02a, 0, 0, Local0, 0xabcd0709)
                    }
                    if (LNotEqual(^^^^^^^^dz05.iy07, 0xabcd0709)) {
                      err(ts, z170, 0x02b, 0, 0, ^^^^^^^^dz05.iy07, 0xabcd0709)
                    }
                  }
                  Increment(^^^^^^^dz05.iy07)
                  mm07()
                }
                Increment(^^^^^^dz05.iy07)
                mm06()
              }
              Increment(^^^^^dz05.iy07)
              mm05()
            }
            Increment(^^^^dz05.iy07)
            mm04()
          }
          Increment(^^^dz05.iy07)
          mm03()
        }
        Increment(^^dz05.iy07)
        mm02()
      }
      Increment(^dz05.iy07)
      mm01()
    }

    CH03(ts, z170, 0x02c, 0, 0)

    Increment(dz05.iy07)
    mm00()

    if (LNotEqual(dz05.iy07, 0xabcd0709)) {
      err(ts, z170, 0x02d, 0, 0, dz05.iy07, 0xabcd0709)
    }

    CH03(ts, z170, 0x02e, 0, 0)
}

/*
 * The same as mt11, but contains more depth of enclosed method calls.
 * To be run on ACPICA only.
 */
Method(mt12,, Serialized)
{
    Name(ts, "mt12")

    Device(dz05)
    {
        Name(iy07, 0xabcd0800)
    }
    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                            Method(mm0c)
                            {
                              Method(mm0d)
                              {
                                Method(mm0e)
                                {
                                  Method(mm0f)
                                  {
                                    Method(mm10)
                                    {
                                      Method(mm11)
                                      {
                                        Method(mm12)
                                        {
                                          Method(mm13)
                                          {
                                            Method(mm14)
                                            {
                                              Method(mm15)
                                              {
                                                Method(mm16)
                                                {
                                                  Method(mm17)
                                                  {
                                                    Method(mm18)
                                                    {
                                                      Method(mm19)
                                                      {
                                                        Method(mm1a)
                                                        {
                                                          Method(mm1b)
                                                          {
                                                            Method(mm1c)
                                                            {
                                                              Method(mm1d)
                                                              {
                                                                Method(mm1e)
                                                                {
                                                                  Method(mm1f)
                                                                  {
                                                                    Increment(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                                    Store (^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                                    OUTC("mt12,   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07:")
                                                                    OUTC(Local0)
                                                                    if (LNotEqual(Local0, 0xabcd0821)) {
                                                                        err(ts, z170, 0x02f, 0, 0, Local0, 0xabcd0821)
                                                                    }
                                                                    if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd0821)) {
                                                                        err(ts, z170, 0x030, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd0821)
                                                                    }
                                                                  }
                                                                  Increment(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                                  mm1f()
                                                                }
                                                                Increment(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                                mm1e()
                                                              }
                                                              Increment(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                              mm1d()
                                                            }
                                                            Increment(^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                            mm1c()
                                                          }
                                                          Increment(^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                          mm1b()
                                                        }
                                                        Increment(^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                        mm1a()
                                                      }
                                                      Increment(^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                      mm19()
                                                    }
                                                    Increment(^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                    mm18()
                                                  }
                                                  Increment(^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                  mm17()
                                                }
                                                Increment(^^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                                mm16()
                                              }
                                              Increment(^^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                              mm15()
                                            }
                                            Increment(^^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                            mm14()
                                          }
                                          Increment(^^^^^^^^^^^^^^^^^^^dz05.iy07)
                                          mm13()
                                        }
                                        Increment(^^^^^^^^^^^^^^^^^^dz05.iy07)
                                        mm12()
                                      }
                                      Increment(^^^^^^^^^^^^^^^^^dz05.iy07)
                                      mm11()
                                    }
                                    Increment(^^^^^^^^^^^^^^^^dz05.iy07)
                                    mm10()
                                  }
                                  Increment(^^^^^^^^^^^^^^^dz05.iy07)
                                  mm0f()
                                }
                                Increment(^^^^^^^^^^^^^^dz05.iy07)
                                mm0e()
                              }
                              Increment(^^^^^^^^^^^^^dz05.iy07)
                              mm0d()
                            }
                            Increment(^^^^^^^^^^^^dz05.iy07)
                            mm0c()
                          }
                          Increment(^^^^^^^^^^^dz05.iy07)
                          mm0b()
                        }
                        Increment(^^^^^^^^^^dz05.iy07)
                        mm0a()
                      }
                      Increment(^^^^^^^^^dz05.iy07)
                      mm09()
                    }
                    Increment(^^^^^^^^dz05.iy07)
                    mm08()
                  }
                  Increment(^^^^^^^dz05.iy07)
                  mm07()
                }
                Increment(^^^^^^dz05.iy07)
                mm06()
              }
              Increment(^^^^^dz05.iy07)
              mm05()
            }
            Increment(^^^^dz05.iy07)
            mm04()
          }
          Increment(^^^dz05.iy07)
          mm03()
        }
        Increment(^^dz05.iy07)
        mm02()
      }
      Increment(^dz05.iy07)
      mm01()
    }

    CH03(ts, z170, 0x11d, 0, 0)

    Increment(dz05.iy07)
    mm00()

    if (LNotEqual(dz05.iy07, 0xabcd0821)) {
        err(ts, z170, 0x031, 0, 0, dz05.iy07, 0xabcd0821)
    }

    CH03(ts, z170, 0x11e, 0, 0)
}

/*
 * Simple Store of object with the name of method in the name path
 */
Method(mt13,, Serialized)
{
    Name(ts, "mt13")

    Device(dz05)
    {
        Name(iy07, 0xabcd0500)
    }

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Store (\mt13.dz05.iy07, Local0)
                  OUTC("mt13,   \\mt13.dz05.iy07:")
                  OUTC(Local0)
                  if (LNotEqual(Local0, 0xabcd0500)) {
                      err(ts, z170, 0x032, 0, 0, Local0, 0xabcd0500)
                  }
                  if (LNotEqual(\mt13.dz05.iy07, 0xabcd0500)) {
                      err(ts, z170, 0x033, 0, 0, \mt13.dz05.iy07, 0xabcd0500)
                  }
                }
                Store (\mt13.dz05.iy07, Local0)
                mm06()
                if (LNotEqual(\mt13.dz05.iy07, 0xabcd0500)) {
                    err(ts, z170, 0x034, 0, 0, \mt13.dz05.iy07, 0xabcd0500)
                }
              }
              Store (\mt13.dz05.iy07, Local0)
              mm05()
              if (LNotEqual(\mt13.dz05.iy07, 0xabcd0500)) {
                  err(ts, z170, 0x035, 0, 0, \mt13.dz05.iy07, 0xabcd0500)
              }
            }
            Store (\mt13.dz05.iy07, Local0)
            mm04()
            if (LNotEqual(\mt13.dz05.iy07, 0xabcd0500)) {
                err(ts, z170, 0x036, 0, 0, \mt13.dz05.iy07, 0xabcd0500)
            }
          }
          Store (\mt13.dz05.iy07, Local0)
          mm03()
          if (LNotEqual(\mt13.dz05.iy07, 0xabcd0500)) {
              err(ts, z170, 0x037, 0, 0, \mt13.dz05.iy07, 0xabcd0500)
          }
        }
        Store (\mt13.dz05.iy07, Local0)
        mm02()
        if (LNotEqual(\mt13.dz05.iy07, 0xabcd0500)) {
            err(ts, z170, 0x038, 0, 0, \mt13.dz05.iy07, 0xabcd0500)
        }
      }
      Store (\mt13.dz05.iy07, Local0)
      mm01()
      if (LNotEqual(\mt13.dz05.iy07, 0xabcd0500)) {
          err(ts, z170, 0x039, 0, 0, \mt13.dz05.iy07, 0xabcd0500)
      }
    }

    CH03(ts, z170, 0x03a, 0, 0)

    Store (\mt13.dz05.iy07, Local0)
    mm00()

    if (LNotEqual(\mt13.dz05.iy07, 0xabcd0500)) {
      err(ts, z170, 0x03b, 0, 0, \mt13.dz05.iy07, 0xabcd0500)
    }

    CH03(ts, z170, 0x03c, 0, 0)
}

/*
 * The same as mt13, but contains more depth of enclosed method calls.
 * To be run on ACPICA only.
 */
Method(mt14,, Serialized)
{
    Name(ts, "mt14")

    Device(dz05)
    {
        Name(iy07, 0xabcd2900)
    }
    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                            Method(mm0c)
                            {
                              Method(mm0d)
                              {
                                Method(mm0e)
                                {
                                  Method(mm0f)
                                  {
                                    Method(mm10)
                                    {
                                      Method(mm11)
                                      {
                                        Method(mm12)
                                        {
                                          Method(mm13)
                                          {
                                            Method(mm14)
                                            {
                                              Method(mm15)
                                              {
                                                Method(mm16)
                                                {
                                                  Method(mm17)
                                                  {
                                                    Method(mm18)
                                                    {
                                                      Method(mm19)
                                                      {
                                                        Method(mm1a)
                                                        {
                                                          Method(mm1b)
                                                          {
                                                            Method(mm1c)
                                                            {
                                                              Method(mm1d)
                                                              {
                                                                Method(mm1e)
                                                                {
                                                                  Method(mm1f)
                                                                  {
                                                                    Store (\mt14.dz05.iy07, Local0)
                                                                    OUTC("mt14,   \\mt14.dz05.iy07:")
                                                                    OUTC(Local0)
                                                                    if (LNotEqual(Local0, 0xabcd2900)) {
                                                                        err(ts, z170, 0x03d, 0, 0, Local0, 0xabcd2900)
                                                                    }
                                                                    if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                                        err(ts, z170, 0x03e, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                                    }
                                                                  }
                                                                  Store (\mt14.dz05.iy07, Local0)
                                                                  mm1f()
                                                                  if (LNotEqual(Local0, 0xabcd2900)) {
                                                                      err(ts, z170, 0x03f, 0, 0, Local0, 0xabcd2900)
                                                                  }
                                                                  if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                                      err(ts, z170, 0x040, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                                  }
                                                                }
                                                                Store (\mt14.dz05.iy07, Local0)
                                                                mm1e()
                                                                if (LNotEqual(Local0, 0xabcd2900)) {
                                                                    err(ts, z170, 0x041, 0, 0, Local0, 0xabcd2900)
                                                                }
                                                                if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                                    err(ts, z170, 0x042, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                                }
                                                              }
                                                              Store (\mt14.dz05.iy07, Local0)
                                                              mm1d()
                                                              if (LNotEqual(Local0, 0xabcd2900)) {
                                                                  err(ts, z170, 0x043, 0, 0, Local0, 0xabcd2900)
                                                              }
                                                              if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                                  err(ts, z170, 0x044, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                              }
                                                            }
                                                            Store (\mt14.dz05.iy07, Local0)
                                                            mm1c()
                                                            if (LNotEqual(Local0, 0xabcd2900)) {
                                                                err(ts, z170, 0x045, 0, 0, Local0, 0xabcd2900)
                                                            }
                                                            if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                                err(ts, z170, 0x046, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                            }
                                                          }
                                                          Store (\mt14.dz05.iy07, Local0)
                                                          mm1b()
                                                          if (LNotEqual(Local0, 0xabcd2900)) {
                                                              err(ts, z170, 0x047, 0, 0, Local0, 0xabcd2900)
                                                          }
                                                          if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                              err(ts, z170, 0x048, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                          }
                                                        }
                                                        Store (\mt14.dz05.iy07, Local0)
                                                        mm1a()
                                                        if (LNotEqual(Local0, 0xabcd2900)) {
                                                            err(ts, z170, 0x049, 0, 0, Local0, 0xabcd2900)
                                                        }
                                                        if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                            err(ts, z170, 0x04a, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                        }
                                                      }
                                                      Store (\mt14.dz05.iy07, Local0)
                                                      mm19()
                                                      if (LNotEqual(Local0, 0xabcd2900)) {
                                                          err(ts, z170, 0x04b, 0, 0, Local0, 0xabcd2900)
                                                      }
                                                      if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                          err(ts, z170, 0x04c, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                      }
                                                    }
                                                    Store (\mt14.dz05.iy07, Local0)
                                                    mm18()
                                                    if (LNotEqual(Local0, 0xabcd2900)) {
                                                        err(ts, z170, 0x04d, 0, 0, Local0, 0xabcd2900)
                                                    }
                                                    if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                        err(ts, z170, 0x04e, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                    }
                                                  }
                                                  Store (\mt14.dz05.iy07, Local0)
                                                  mm17()
                                                  if (LNotEqual(Local0, 0xabcd2900)) {
                                                      err(ts, z170, 0x04f, 0, 0, Local0, 0xabcd2900)
                                                  }
                                                  if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                      err(ts, z170, 0x050, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                  }
                                                }
                                                Store (\mt14.dz05.iy07, Local0)
                                                mm16()
                                                if (LNotEqual(Local0, 0xabcd2900)) {
                                                    err(ts, z170, 0x051, 0, 0, Local0, 0xabcd2900)
                                                }
                                                if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                    err(ts, z170, 0x052, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                                }
                                              }
                                              Store (\mt14.dz05.iy07, Local0)
                                              mm15()
                                              if (LNotEqual(Local0, 0xabcd2900)) {
                                                  err(ts, z170, 0x053, 0, 0, Local0, 0xabcd2900)
                                              }
                                              if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                  err(ts, z170, 0x054, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                              }
                                            }
                                            Store (\mt14.dz05.iy07, Local0)
                                            mm14()
                                            if (LNotEqual(Local0, 0xabcd2900)) {
                                                err(ts, z170, 0x055, 0, 0, Local0, 0xabcd2900)
                                            }
                                            if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                                err(ts, z170, 0x056, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                            }
                                          }
                                          Store (\mt14.dz05.iy07, Local0)
                                          mm13()
                                          if (LNotEqual(Local0, 0xabcd2900)) {
                                              err(ts, z170, 0x057, 0, 0, Local0, 0xabcd2900)
                                          }
                                          if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                              err(ts, z170, 0x058, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                          }
                                        }
                                        Store (\mt14.dz05.iy07, Local0)
                                        mm12()
                                        if (LNotEqual(Local0, 0xabcd2900)) {
                                            err(ts, z170, 0x059, 0, 0, Local0, 0xabcd2900)
                                        }
                                        if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                            err(ts, z170, 0x05a, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                        }
                                      }
                                      Store (\mt14.dz05.iy07, Local0)
                                      mm11()
                                      if (LNotEqual(Local0, 0xabcd2900)) {
                                          err(ts, z170, 0x05b, 0, 0, Local0, 0xabcd2900)
                                      }
                                      if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                          err(ts, z170, 0x05c, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                      }
                                    }
                                    Store (\mt14.dz05.iy07, Local0)
                                    mm10()
                                    if (LNotEqual(Local0, 0xabcd2900)) {
                                        err(ts, z170, 0x05d, 0, 0, Local0, 0xabcd2900)
                                    }
                                    if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                        err(ts, z170, 0x05e, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                    }
                                  }
                                  Store (\mt14.dz05.iy07, Local0)
                                  mm0f()
                                  if (LNotEqual(Local0, 0xabcd2900)) {
                                      err(ts, z170, 0x05f, 0, 0, Local0, 0xabcd2900)
                                  }
                                  if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                      err(ts, z170, 0x060, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                  }
                                }
                                Store (\mt14.dz05.iy07, Local0)
                                mm0e()
                                if (LNotEqual(Local0, 0xabcd2900)) {
                                    err(ts, z170, 0x061, 0, 0, Local0, 0xabcd2900)
                                }
                                if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                    err(ts, z170, 0x062, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                                }
                              }
                              Store (\mt14.dz05.iy07, Local0)
                              mm0d()
                              if (LNotEqual(Local0, 0xabcd2900)) {
                                  err(ts, z170, 0x063, 0, 0, Local0, 0xabcd2900)
                              }
                              if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                  err(ts, z170, 0x064, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                              }
                            }
                            Store (\mt14.dz05.iy07, Local0)
                            mm0c()
                            if (LNotEqual(Local0, 0xabcd2900)) {
                                err(ts, z170, 0x065, 0, 0, Local0, 0xabcd2900)
                            }
                            if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                                err(ts, z170, 0x066, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                            }
                          }
                          Store (\mt14.dz05.iy07, Local0)
                          mm0b()
                          if (LNotEqual(Local0, 0xabcd2900)) {
                              err(ts, z170, 0x067, 0, 0, Local0, 0xabcd2900)
                          }
                          if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                              err(ts, z170, 0x068, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                          }
                        }
                        Store (\mt14.dz05.iy07, Local0)
                        mm0a()
                        if (LNotEqual(Local0, 0xabcd2900)) {
                            err(ts, z170, 0x069, 0, 0, Local0, 0xabcd2900)
                        }
                        if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                            err(ts, z170, 0x06a, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                        }
                      }
                      Store (\mt14.dz05.iy07, Local0)
                      mm09()
                      if (LNotEqual(Local0, 0xabcd2900)) {
                          err(ts, z170, 0x06b, 0, 0, Local0, 0xabcd2900)
                      }
                      if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                          err(ts, z170, 0x06c, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                      }
                    }
                    Store (\mt14.dz05.iy07, Local0)
                    mm08()
                    if (LNotEqual(Local0, 0xabcd2900)) {
                        err(ts, z170, 0x06d, 0, 0, Local0, 0xabcd2900)
                    }
                    if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                        err(ts, z170, 0x06e, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                    }
                  }
                  Store (\mt14.dz05.iy07, Local0)
                  mm07()
                  if (LNotEqual(Local0, 0xabcd2900)) {
                      err(ts, z170, 0x06f, 0, 0, Local0, 0xabcd2900)
                  }
                  if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                      err(ts, z170, 0x070, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                  }
                }
                Store (\mt14.dz05.iy07, Local0)
                mm06()
                if (LNotEqual(Local0, 0xabcd2900)) {
                    err(ts, z170, 0x071, 0, 0, Local0, 0xabcd2900)
                }
                if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                    err(ts, z170, 0x072, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
                }
              }
              Store (\mt14.dz05.iy07, Local0)
              mm05()
              if (LNotEqual(Local0, 0xabcd2900)) {
                  err(ts, z170, 0x073, 0, 0, Local0, 0xabcd2900)
              }
              if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                  err(ts, z170, 0x074, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
              }
            }
            Store (\mt14.dz05.iy07, Local0)
            mm04()
            if (LNotEqual(Local0, 0xabcd2900)) {
                err(ts, z170, 0x075, 0, 0, Local0, 0xabcd2900)
            }
            if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
                err(ts, z170, 0x076, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
            }
          }
          Store (\mt14.dz05.iy07, Local0)
          mm03()
          if (LNotEqual(Local0, 0xabcd2900)) {
              err(ts, z170, 0x077, 0, 0, Local0, 0xabcd2900)
          }
          if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
              err(ts, z170, 0x078, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
          }
        }
        Store (\mt14.dz05.iy07, Local0)
        mm02()
        if (LNotEqual(Local0, 0xabcd2900)) {
            err(ts, z170, 0x079, 0, 0, Local0, 0xabcd2900)
        }
        if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
            err(ts, z170, 0x07a, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
        }
      }
      Store (\mt14.dz05.iy07, Local0)
      mm01()
      if (LNotEqual(Local0, 0xabcd2900)) {
          err(ts, z170, 0x07b, 0, 0, Local0, 0xabcd2900)
      }
      if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
          err(ts, z170, 0x07c, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
      }
    }

    CH03(ts, z170, 0x11f, 0, 0)

    Store (\mt14.dz05.iy07, Local0)
    mm00()
    if (LNotEqual(Local0, 0xabcd2900)) {
        err(ts, z170, 0x07d, 0, 0, Local0, 0xabcd2900)
    }
    if (LNotEqual(\mt14.dz05.iy07, 0xabcd2900)) {
        err(ts, z170, 0x07e, 0, 0, \mt14.dz05.iy07, 0xabcd2900)
    }

    CH03(ts, z170, 0x120, 0, 0)
}

/*
 * The same as mt14, but contains parent name paths.
 * To be run on ACPICA only.
 */
Method(mt15,, Serialized)
{
    Name(ts, "mt15")

    Device(dz05)
    {
        Name(iy07, 0xabcd3900)
    }
    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                            Method(mm0c)
                            {
                              Method(mm0d)
                              {
                                Method(mm0e)
                                {
                                  Method(mm0f)
                                  {
                                    Method(mm10)
                                    {
                                      Method(mm11)
                                      {
                                        Method(mm12)
                                        {
                                          Method(mm13)
                                          {
                                            Method(mm14)
                                            {
                                              Method(mm15)
                                              {
                                                Method(mm16)
                                                {
                                                  Method(mm17)
                                                  {
                                                    Method(mm18)
                                                    {
                                                      Method(mm19)
                                                      {
                                                        Method(mm1a)
                                                        {
                                                          Method(mm1b)
                                                          {
                                                            Method(mm1c)
                                                            {
                                                              Method(mm1d)
                                                              {
                                                                Method(mm1e)
                                                                {
                                                                  Method(mm1f)
                                                                  {
                                                                    Store (^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                                    OUTC("mt15,   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07:")
                                                                    OUTC(Local0)
                                                                    if (LNotEqual(Local0, 0xabcd3900)) {
                                                                        err(ts, z170, 0x07f, 0, 0, Local0, 0xabcd3900)
                                                                    }
                                                                    if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                                        err(ts, z170, 0x080, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                                    }
                                                                  }
                                                                  Store (^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                                  mm1f()
                                                                  if (LNotEqual(Local0, 0xabcd3900)) {
                                                                      err(ts, z170, 0x081, 0, 0, Local0, 0xabcd3900)
                                                                  }
                                                                  if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                                      err(ts, z170, 0x082, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                                  }
                                                                }
                                                                Store (^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                                mm1e()
                                                                if (LNotEqual(Local0, 0xabcd3900)) {
                                                                    err(ts, z170, 0x083, 0, 0, Local0, 0xabcd3900)
                                                                }
                                                                if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                                    err(ts, z170, 0x084, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                                }
                                                              }
                                                              Store (^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                              mm1d()
                                                              if (LNotEqual(Local0, 0xabcd3900)) {
                                                                  err(ts, z170, 0x085, 0, 0, Local0, 0xabcd3900)
                                                              }
                                                              if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                                  err(ts, z170, 0x086, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                              }
                                                            }
                                                            Store (^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                            mm1c()
                                                            if (LNotEqual(Local0, 0xabcd3900)) {
                                                                err(ts, z170, 0x087, 0, 0, Local0, 0xabcd3900)
                                                            }
                                                            if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                                err(ts, z170, 0x088, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                            }
                                                          }
                                                          Store (^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                          mm1b()
                                                          if (LNotEqual(Local0, 0xabcd3900)) {
                                                              err(ts, z170, 0x089, 0, 0, Local0, 0xabcd3900)
                                                          }
                                                          if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                              err(ts, z170, 0x08a, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                          }
                                                        }
                                                        Store (^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                        mm1a()
                                                        if (LNotEqual(Local0, 0xabcd3900)) {
                                                            err(ts, z170, 0x08b, 0, 0, Local0, 0xabcd3900)
                                                        }
                                                        if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                            err(ts, z170, 0x08c, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                        }
                                                      }
                                                      Store (^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                      mm19()
                                                      if (LNotEqual(Local0, 0xabcd3900)) {
                                                          err(ts, z170, 0x08d, 0, 0, Local0, 0xabcd3900)
                                                      }
                                                      if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                          err(ts, z170, 0x08e, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                      }
                                                    }
                                                    Store (^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                    mm18()
                                                    if (LNotEqual(Local0, 0xabcd3900)) {
                                                        err(ts, z170, 0x08f, 0, 0, Local0, 0xabcd3900)
                                                    }
                                                    if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                        err(ts, z170, 0x090, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                    }
                                                  }
                                                  Store (^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                  mm17()
                                                  if (LNotEqual(Local0, 0xabcd3900)) {
                                                      err(ts, z170, 0x091, 0, 0, Local0, 0xabcd3900)
                                                  }
                                                  if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                      err(ts, z170, 0x092, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                  }
                                                }
                                                Store (^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                                mm16()
                                                if (LNotEqual(Local0, 0xabcd3900)) {
                                                    err(ts, z170, 0x093, 0, 0, Local0, 0xabcd3900)
                                                }
                                                if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                    err(ts, z170, 0x094, 0, 0, ^^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                                }
                                              }
                                              Store (^^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                              mm15()
                                              if (LNotEqual(Local0, 0xabcd3900)) {
                                                  err(ts, z170, 0x095, 0, 0, Local0, 0xabcd3900)
                                              }
                                              if (LNotEqual(^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                  err(ts, z170, 0x096, 0, 0, ^^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                              }
                                            }
                                            Store (^^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                            mm14()
                                            if (LNotEqual(Local0, 0xabcd3900)) {
                                                err(ts, z170, 0x097, 0, 0, Local0, 0xabcd3900)
                                            }
                                            if (LNotEqual(^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                                err(ts, z170, 0x098, 0, 0, ^^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                            }
                                          }
                                          Store (^^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                          mm13()
                                          if (LNotEqual(Local0, 0xabcd3900)) {
                                              err(ts, z170, 0x099, 0, 0, Local0, 0xabcd3900)
                                          }
                                          if (LNotEqual(^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                              err(ts, z170, 0x09a, 0, 0, ^^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                          }
                                        }
                                        Store (^^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                        mm12()
                                        if (LNotEqual(Local0, 0xabcd3900)) {
                                            err(ts, z170, 0x09b, 0, 0, Local0, 0xabcd3900)
                                        }
                                        if (LNotEqual(^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                            err(ts, z170, 0x09c, 0, 0, ^^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                        }
                                      }
                                      Store (^^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                      mm11()
                                      if (LNotEqual(Local0, 0xabcd3900)) {
                                          err(ts, z170, 0x09d, 0, 0, Local0, 0xabcd3900)
                                      }
                                      if (LNotEqual(^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                          err(ts, z170, 0x09e, 0, 0, ^^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                      }
                                    }
                                    Store (^^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                    mm10()
                                    if (LNotEqual(Local0, 0xabcd3900)) {
                                        err(ts, z170, 0x09f, 0, 0, Local0, 0xabcd3900)
                                    }
                                    if (LNotEqual(^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                        err(ts, z170, 0x0a0, 0, 0, ^^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                    }
                                  }
                                  Store (^^^^^^^^^^^^^^^dz05.iy07, Local0)
                                  mm0f()
                                  if (LNotEqual(Local0, 0xabcd3900)) {
                                      err(ts, z170, 0x0a1, 0, 0, Local0, 0xabcd3900)
                                  }
                                  if (LNotEqual(^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                      err(ts, z170, 0x0a2, 0, 0, ^^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                  }
                                }
                                Store (^^^^^^^^^^^^^^dz05.iy07, Local0)
                                mm0e()
                                if (LNotEqual(Local0, 0xabcd3900)) {
                                    err(ts, z170, 0x0a3, 0, 0, Local0, 0xabcd3900)
                                }
                                if (LNotEqual(^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                    err(ts, z170, 0x0a4, 0, 0, ^^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                                }
                              }
                              Store (^^^^^^^^^^^^^dz05.iy07, Local0)
                              mm0d()
                              if (LNotEqual(Local0, 0xabcd3900)) {
                                  err(ts, z170, 0x0a5, 0, 0, Local0, 0xabcd3900)
                              }
                              if (LNotEqual(^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                  err(ts, z170, 0x0a6, 0, 0, ^^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                              }
                            }
                            Store (^^^^^^^^^^^^dz05.iy07, Local0)
                            mm0c()
                            if (LNotEqual(Local0, 0xabcd3900)) {
                                err(ts, z170, 0x0a7, 0, 0, Local0, 0xabcd3900)
                            }
                            if (LNotEqual(^^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                                err(ts, z170, 0x0a8, 0, 0, ^^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                            }
                          }
                          Store (^^^^^^^^^^^dz05.iy07, Local0)
                          mm0b()
                          if (LNotEqual(Local0, 0xabcd3900)) {
                              err(ts, z170, 0x0a9, 0, 0, Local0, 0xabcd3900)
                          }
                          if (LNotEqual(^^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                              err(ts, z170, 0x0aa, 0, 0, ^^^^^^^^^^^dz05.iy07, 0xabcd3900)
                          }
                        }
                        Store (^^^^^^^^^^dz05.iy07, Local0)
                        mm0a()
                        if (LNotEqual(Local0, 0xabcd3900)) {
                            err(ts, z170, 0x0ab, 0, 0, Local0, 0xabcd3900)
                        }
                        if (LNotEqual(^^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                            err(ts, z170, 0x0ac, 0, 0, ^^^^^^^^^^dz05.iy07, 0xabcd3900)
                        }
                      }
                      Store (^^^^^^^^^dz05.iy07, Local0)
                      mm09()
                      if (LNotEqual(Local0, 0xabcd3900)) {
                          err(ts, z170, 0x0ad, 0, 0, Local0, 0xabcd3900)
                      }
                      if (LNotEqual(^^^^^^^^^dz05.iy07, 0xabcd3900)) {
                          err(ts, z170, 0x0ae, 0, 0, ^^^^^^^^^dz05.iy07, 0xabcd3900)
                      }
                    }
                    Store (^^^^^^^^dz05.iy07, Local0)
                    mm08()
                    if (LNotEqual(Local0, 0xabcd3900)) {
                        err(ts, z170, 0x0af, 0, 0, Local0, 0xabcd3900)
                    }
                    if (LNotEqual(^^^^^^^^dz05.iy07, 0xabcd3900)) {
                        err(ts, z170, 0x0b0, 0, 0, ^^^^^^^^dz05.iy07, 0xabcd3900)
                    }
                  }
                  Store (^^^^^^^dz05.iy07, Local0)
                  mm07()
                  if (LNotEqual(Local0, 0xabcd3900)) {
                      err(ts, z170, 0x0b1, 0, 0, Local0, 0xabcd3900)
                  }
                  if (LNotEqual(^^^^^^^dz05.iy07, 0xabcd3900)) {
                      err(ts, z170, 0x0b2, 0, 0, ^^^^^^^dz05.iy07, 0xabcd3900)
                  }
                }
                Store (^^^^^^dz05.iy07, Local0)
                mm06()
                if (LNotEqual(Local0, 0xabcd3900)) {
                    err(ts, z170, 0x0b3, 0, 0, Local0, 0xabcd3900)
                }
                if (LNotEqual(^^^^^^dz05.iy07, 0xabcd3900)) {
                    err(ts, z170, 0x0b4, 0, 0, ^^^^^^dz05.iy07, 0xabcd3900)
                }
              }
              Store (^^^^^dz05.iy07, Local0)
              mm05()
              if (LNotEqual(Local0, 0xabcd3900)) {
                  err(ts, z170, 0x0b5, 0, 0, Local0, 0xabcd3900)
              }
              if (LNotEqual(^^^^^dz05.iy07, 0xabcd3900)) {
                  err(ts, z170, 0x0b6, 0, 0, ^^^^^dz05.iy07, 0xabcd3900)
              }
            }
            Store (^^^^dz05.iy07, Local0)
            mm04()
            if (LNotEqual(Local0, 0xabcd3900)) {
                err(ts, z170, 0x0b7, 0, 0, Local0, 0xabcd3900)
            }
            if (LNotEqual(^^^^dz05.iy07, 0xabcd3900)) {
                err(ts, z170, 0x0b8, 0, 0, ^^^^dz05.iy07, 0xabcd3900)
            }
          }
          Store (^^^dz05.iy07, Local0)
          mm03()
          if (LNotEqual(Local0, 0xabcd3900)) {
              err(ts, z170, 0x0b9, 0, 0, Local0, 0xabcd3900)
          }
          if (LNotEqual(^^^dz05.iy07, 0xabcd3900)) {
              err(ts, z170, 0x0ba, 0, 0, ^^^dz05.iy07, 0xabcd3900)
          }
        }
        Store (^^dz05.iy07, Local0)
        mm02()
        if (LNotEqual(Local0, 0xabcd3900)) {
            err(ts, z170, 0x0bb, 0, 0, Local0, 0xabcd3900)
        }
        if (LNotEqual(^^dz05.iy07, 0xabcd3900)) {
            err(ts, z170, 0x0bc, 0, 0, ^^dz05.iy07, 0xabcd3900)
        }
      }
      Store (^dz05.iy07, Local0)
      mm01()
      if (LNotEqual(Local0, 0xabcd3900)) {
          err(ts, z170, 0x0bd, 0, 0, Local0, 0xabcd3900)
      }
      if (LNotEqual(^dz05.iy07, 0xabcd3900)) {
          err(ts, z170, 0x0be, 0, 0, ^dz05.iy07, 0xabcd3900)
      }
    }

    CH03(ts, z170, 0x121, 0, 0)

    Store (dz05.iy07, Local0)
    mm00()
    if (LNotEqual(Local0, 0xabcd3900)) {
        err(ts, z170, 0x0bf, 0, 0, Local0, 0xabcd3900)
    }
    if (LNotEqual(dz05.iy07, 0xabcd3900)) {
        err(ts, z170, 0x0c0, 0, 0, dz05.iy07, 0xabcd3900)
    }

    CH03(ts, z170, 0x122, 0, 0)
}

/*
 * Access to the internal object of invoked method
 */
Method(mt16, 1, Serialized)
{
    Name(ts, "mt16")

    Name(i000, 0)
    Name(i001, 0)

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04,, Serialized)
            {
                Device(dz05)
                {
                  Name(iy07, 0xabcd4900)
                }
                if (LEqual(i001, 1)) {
                    Store(0xabcd4904, dz05.iy07)
                    m001(1)
                } elseif (LEqual(i001, 2)) {
                    Store(0xabcd4905, dz05.iy07)
                    m001(2)
                } elseif (LEqual(i001, 3)) {
                    m001(3)
                }
            }
            mm04()
          }
          mm03()
        }
        mm02()
      }
      mm01()
    }

    Method(m000)
    {
      Store (^mm00.mm01.mm02.mm03.mm04.dz05.iy07, i000)
    }

    Method(m001, 1)
    {
      Method(mmF1, 1)
      {
        Method(mmF2, 1, Serialized)
        {
            Device(dz05)
            {
              Name(iy07, 0xabcd6900)
            }
            if (LEqual(arg0, 1)) {
                Store (\mt16.mm00.mm01.mm02.mm03.mm04.dz05.iy07, i000)
            } elseif (LEqual(arg0, 2)) {
                Store (^^^mm00.mm01.mm02.mm03.mm04.dz05.iy07, i000)
            } elseif (LEqual(arg0, 3)) {
                Store (^^mmF1.mmF2.dz05.iy07, i000)
            }
        }
        mmF2(arg0)
      }
      mmF1(arg0)
    }

    CH03(ts, z170, 0x0c1, 0, 0)

    if (LEqual(arg0, 0)) {
        // Access to the internal data of method (mm00...) not being invoked
        m000()
        CH04(ts, 1, 5, z170, 0x0c2, 0, 0) // AE_NOT_FOUND
    } elseif (LEqual(arg0, 1)) {

        // Access to the internal data of method (mm00...) being invoked
        // by \mt16.mm00....

        Store(0, i000)
        Store(1, i001)
        mm00()
        if (LNotEqual(i000, 0xabcd4904)) {
            err(ts, z170, 0x0c3, 0, 0, i000, 0xabcd4904)
        }
    } elseif (LEqual(arg0, 2)) {

        // Access to the internal data of method (mm00...) being invoked
        // by ^^^^^^^^^^^^mm00...

        Store(2, i001)
        mm00()
        if (LNotEqual(i000, 0xabcd4905)) {
            err(ts, z170, 0x0c4, 0, 0, i000, 0xabcd4905)
        }

    } elseif (LEqual(arg0, 3)) {

        // Access to the internal data of method (m001.mmF1.mmF2.mmF3.dz05.iy07...)
        // being invoked by ^^^^^^^^^^^^mm01...

        Store(3, i001)
        mm00()
        if (LNotEqual(i000, 0xabcd6900)) {
            err(ts, z170, 0x1c4, 0, 0, i000, 0xabcd6900)
        }
    }

    CH03(ts, z170, 0x0c5, 0, 0)
}

/*
 * The same as mt16, but contains more depth of enclosed method calls.
 * To be run on ACPICA only.
 */
Method(mt17, 1, Serialized)
{
    Name(ts, "mt17")

    Name(i000, 0)
    Name(i001, 0)

    Method(mm00)
    {
      Method(mm01)
      {
        Method(mm02)
        {
          Method(mm03)
          {
            Method(mm04)
            {
              Method(mm05)
              {
                Method(mm06)
                {
                  Method(mm07)
                  {
                    Method(mm08)
                    {
                      Method(mm09)
                      {
                        Method(mm0a)
                        {
                          Method(mm0b)
                          {
                            Method(mm0c)
                            {
                              Method(mm0d)
                              {
                                Method(mm0e)
                                {
                                  Method(mm0f)
                                  {
                                    Method(mm10)
                                    {
                                      Method(mm11)
                                      {
                                        Method(mm12)
                                        {
                                          Method(mm13)
                                          {
                                            Method(mm14)
                                            {
                                              Method(mm15)
                                              {
                                                Method(mm16)
                                                {
                                                  Method(mm17)
                                                  {
                                                    Method(mm18)
                                                    {
                                                      Method(mm19)
                                                      {
                                                        Method(mm1a)
                                                        {
                                                          Method(mm1b)
                                                          {
                                                            Method(mm1c)
                                                            {
                                                              Method(mm1d)
                                                              {
                                                                Method(mm1e)
                                                                {
                                                                  Method(mm1f)
                                                                  {
                                                                    Method(mm20)
                                                                    {
                                                                      Method(mm21,, Serialized)
                                                                      {
                                                                        Device(dz05)
                                                                        {
                                                                          Name(iy07, 0xabcd5900)
                                                                        }
                                                                        Method(mm22)
                                                                        {
                                                                          Method(mm23)
                                                                          {
                                                                            Method(mm24)
                                                                            {
                                                                              Method(mm25)
                                                                              {
                                                                                if (LEqual(i001, 1)) {
                                                                                    Store(0xabcd4906, ^^^^dz05.iy07)
                                                                                    m001(1)
                                                                                } elseif (LEqual(i001, 2)) {
                                                                                    Store(0xabcd4907, ^^^^dz05.iy07)
                                                                                    m001(2)
                                                                                } elseif (LEqual(i001, 3)) {
                                                                                    m001(3)
                                                                                }
                                                                              }
                                                                              mm25()
                                                                            }
                                                                            mm24()
                                                                          }
                                                                          mm23()
                                                                        }
                                                                        mm22()
                                                                      }
                                                                      mm21()
                                                                    }
                                                                    mm20()
                                                                  }
                                                                  mm1f()
                                                                }
                                                                mm1e()
                                                              }
                                                              mm1d()
                                                            }
                                                            mm1c()
                                                          }
                                                          mm1b()
                                                        }
                                                        mm1a()
                                                      }
                                                      mm19()
                                                    }
                                                    mm18()
                                                  }
                                                  mm17()
                                                }
                                                mm16()
                                              }
                                              mm15()
                                            }
                                            mm14()
                                          }
                                          mm13()
                                        }
                                        mm12()
                                      }
                                      mm11()
                                    }
                                    mm10()
                                  }
                                  mm0f()
                                }
                                mm0e()
                              }
                              mm0d()
                            }
                            mm0c()
                          }
                          mm0b()
                        }
                        mm0a()
                      }
                      mm09()
                    }
                    mm08()
                  }
                  mm07()
                }
                mm06()
              }
              mm05()
            }
            mm04()
          }
          mm03()
        }
        mm02()
      }
      mm01()
    }

    Method(m000)
    {
      Store (^mm00.mm01.mm02.mm03.mm04.mm05.mm06.mm07.mm08.mm09.mm0a.mm0b.mm0c.mm0d.mm0e.mm0f.mm10.mm11.mm12.mm13.mm14.mm15.mm16.mm17.mm18.mm19.mm1a.mm1b.mm1c.mm1d.mm1e.mm1f.mm20.mm21.dz05.iy07, i000)
    }

    Method(m001, 1)
    {
      Method(mmF1, 1)
      {
        Method(mmF2, 1)
        {
          Method(mmF3, 1)
          {
            Method(mmF4, 1)
            {
              Method(mmF5, 1)
              {
                Method(mmF6, 1)
                {
                  Method(mmF7, 1)
                  {
                    Method(mmF8, 1)
                    {
                      Method(mmF9, 1)
                      {
                        Method(mmFa, 1)
                        {
                          Method(mmFb, 1)
                          {
                            Method(mmFc, 1)
                            {
                              Method(mmFd, 1)
                              {
                                Method(mmFe, 1)
                                {
                                  Method(mmFf, 1)
                                  {
                                    Method(mm10, 1)
                                    {
                                      Method(mm11, 1, Serialized)
                                      {
                                        Device(dz05)
                                        {
                                          Name(iy07, 0xabcd4908)
                                        }
                                        Method(mm12, 1)
                                        {
                                          Method(mm13, 1)
                                          {
                                            Method(mm14, 1)
                                            {
                                              Method(mm15, 1)
                                              {
                                                Method(mm16, 1)
                                                {
                                                  Method(mm17, 1)
                                                  {
                                                    Method(mm18, 1)
                                                    {
                                                      Method(mm19, 1)
                                                      {
                                                        Method(mm1a, 1)
                                                        {
                                                          Method(mm1b, 1)
                                                          {
                                                            Method(mm1c, 1)
                                                            {
                                                              Method(mm1d, 1)
                                                              {
                                                                Method(mm1e, 1)
                                                                {
                                                                  Method(mm1f, 1)
                                                                  {
if (LEqual(arg0, 1)) {
    Store (\mt17.mm00.mm01.mm02.mm03.mm04.mm05.mm06.mm07.mm08.mm09.mm0a.mm0b.mm0c.mm0d.mm0e.mm0f.mm10.mm11.mm12.mm13.mm14.mm15.mm16.mm17.mm18.mm19.mm1a.mm1b.mm1c.mm1d.mm1e.mm1f.mm20.mm21.dz05.iy07, i000)
} elseif (LEqual(arg0, 2)) {
    Store (^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^mm00.mm01.mm02.mm03.mm04.mm05.mm06.mm07.mm08.mm09.mm0a.mm0b.mm0c.mm0d.mm0e.mm0f.mm10.mm11.mm12.mm13.mm14.mm15.mm16.mm17.mm18.mm19.mm1a.mm1b.mm1c.mm1d.mm1e.mm1f.mm20.mm21.dz05.iy07, i000)
} elseif (LEqual(arg0, 3)) {
    Store (^^^^^^^^^^^^^^^^^^^^^^^^^^mmF6.mmF7.mmF8.mmF9.mmFa.mmFb.mmFc.mmFd.mmFe.mmFf.mm10.mm11.dz05.iy07, i000)
}
                                                                  }
                                                                  mm1f(arg0)
                                                                }
                                                                mm1e(arg0)
                                                              }
                                                              mm1d(arg0)
                                                            }
                                                            mm1c(arg0)
                                                          }
                                                          mm1b(arg0)
                                                        }
                                                        mm1a(arg0)
                                                      }
                                                      mm19(arg0)
                                                    }
                                                    mm18(arg0)
                                                  }
                                                  mm17(arg0)
                                                }
                                                mm16(arg0)
                                              }
                                              mm15(arg0)
                                            }
                                            mm14(arg0)
                                          }
                                          mm13(arg0)
                                        }
                                        mm12(arg0)
                                      }
                                      mm11(arg0)
                                    }
                                    mm10(arg0)
                                  }
                                  mmFf(arg0)
                                }
                                mmFe(arg0)
                              }
                              mmFd(arg0)
                            }
                            mmFc(arg0)
                          }
                          mmFb(arg0)
                        }
                        mmFa(arg0)
                      }
                      mmF9(arg0)
                    }
                    mmF8(arg0)
                  }
                  mmF7(arg0)
                }
                mmF6(arg0)
              }
              mmF5(arg0)
            }
            mmF4(arg0)
          }
          mmF3(arg0)
        }
        mmF2(arg0)
      }
      mmF1(arg0)
    }

    CH03(ts, z170, 0x0c6, 0, 0)

    if (LEqual(arg0, 0)) {
        // Access to the internal data of method (mm00...) not being invoked
        m000()
        CH04(ts, 1, 5, z170, 0x0c7, 0, 0) // AE_NOT_FOUND
    } elseif (LEqual(arg0, 1)) {

        // Access to the internal data of method (mm00...) being invoked
        // by \mt16.mm00....

        Store(1, i001)
        mm00()
        if (LNotEqual(i000, 0xabcd4906)) {
            err(ts, z170, 0x0c8, 0, 0, i000, 0xabcd4906)
        }
    } elseif (LEqual(arg0, 2)) {

        // Access to the internal data of method (mm00...) being invoked
        // by ^^^^^^^^^^^^mm00...

        Store(2, i001)
        mm00()
        if (LNotEqual(i000, 0xabcd4907)) {
            err(ts, z170, 0x0c9, 0, 0, i000, 0xabcd4907)
        }

    } elseif (LEqual(arg0, 3)) {

        // Access to the internal data of method (m001.mmF1.mmF2.mmF3.dz05.iy07...)
        // being invoked by ^^^^^^^^^^^^mm01...

        Store(3, i001)
        mm00()
        if (LNotEqual(i000, 0xabcd4908)) {
            err(ts, z170, 0x0ca, 0, 0, i000, 0xabcd4908)
        }
    }

    CH03(ts, z170, 0x0cb, 0, 0)
}

Method(mt18, 1, Serialized)
{
	Name(ts, "mt18")

	Device(dz05)
	{
		Name(iy07, 0xabcd4900)
	}

	CH03(ts, z170, 0x0cc, 0, 0)

	if (arg0) {
		Store(0xabcd9000, \mt18.dz05.iy07)
            if (LNotEqual(\mt18.dz05.iy07, 0xabcd9000)) {
                err(ts, z170, 0x0ca, 0, 0, \mt18.dz05.iy07, 0xabcd9000)
            }
	} else {
		Store(0xabcd9001, dz05.iy07)
            if (LNotEqual(dz05.iy07, 0xabcd9001)) {
                err(ts, z170, 0x0ca, 0, 0, dz05.iy07, 0xabcd9001)
            }
	}

	CH03(ts, z170, 0x0cd, 0, 0)
}

Method(mt19, 1, Serialized)
{
	Name(ts, "mt19")

	Processor(pr7d, 0, 0x000, 0x008)
	{
		Name(iy07, 0xabcd0660)
	}

	CH03(ts, z170, 0x0ce, 0, 0)

	if (arg0) {
		Store(0xabcd9002, \mt19.pr7d.iy07)
            if (LNotEqual(\mt19.pr7d.iy07, 0xabcd9002)) {
                err(ts, z170, 0x0ca, 0, 0, \mt19.pr7d.iy07, 0xabcd9002)
            }
	} else {
		Store(0xabcd9003, pr7d.iy07)
            if (LNotEqual(pr7d.iy07, 0xabcd9003)) {
                err(ts, z170, 0x0ca, 0, 0, pr7d.iy07, 0xabcd9003)
            }
	}

	CH03(ts, z170, 0x0cf, 0, 0)
}

Method(mt1a, 1, Serialized)
{
	Name(ts, "mt1a")

	CH03(ts, z170, 0x0d0, 0, 0)
	if (arg0) {
		Store(0xabcd9004, \pr7d.iy07)
            if (LNotEqual(\pr7d.iy07, 0xabcd9004)) {
                err(ts, z170, 0x0ca, 0, 0, \pr7d.iy07, 0xabcd9004)
            }
	} else {
		Store(0xabcd9005, ^pr7d.iy07)
            if (LNotEqual(^pr7d.iy07, 0xabcd9005)) {
                err(ts, z170, 0x0ca, 0, 0, ^pr7d.iy07, 0xabcd9005)
            }
	}
	CH03(ts, z170, 0x0d1, 0, 0)
}


Method(mtff,, Serialized)
{
	Name(run0, 1)

	// Works on both
	SRMT("mt00")
	mt00()

	if (chk0) {
		// Exceeded the depth supported on MS
		SRMT("mt01")
		mt01()
	}

	// Works on both
	SRMT("mt02")
	mt02()

	if (chk0) {
		// Exceeded the depth supported on MS
		SRMT("mt03")
		mt03()
	}

	if (run0) {
		// Works on MS, AE_AML_OPERAND_TYPE on ACPICA
		SRMT("mt04")
		mt04()
	}

	if (LAnd(chk0, run0)) {
		// Exceeded the depth supported on MS
		SRMT("mt05")
		mt05()
	}

	if (run0) {
		// Works on MS, AE_NOT_FOUND on ACPICA
		SRMT("mt06")
		mt06()
	}

	if (0) {
		// Fails for both here - for MS and ACPICA
		SRMT("mt07")
		mt07()
	}

	if (chk0) {
		// Exceeded the depth supported on MS
		SRMT("mt08")
		mt08()
	}

	// Works on both
	SRMT("mt0a")
	mt0a()
	SRMT("mt0b")
	mt0b()

	if (run0) {
		// Works on MS, AE_AML_OPERAND_TYPE on ACPICA
		SRMT("mt0c")
		mt0c()
	}

	// Simply long cycle in While
	SRMT("mt0d")
	mt0d()

	if (0) {
		SRMT("mt0e")
		mt0e() // Result: ACPICA - AE_NOT_FOUND, MS - Failure
	}

	if (run0) {
		// Works on MS, AE_AML_OPERAND_TYPE on ACPICA
		SRMT("mt0f")
		mt0f()
	}

	if (LAnd(chk0, run0)) {
		// Exceeded the depth supported on MS
		SRMT("mt10")
		mt10()
	}

	if (run0) {
		// Works on MS, AE_AML_OPERAND_TYPE on ACPICA
		SRMT("mt11")
		mt11()
	}

	if (LAnd(chk0, run0)) {
		// Exceeded the depth supported on MS
		SRMT("mt12")
		mt12()
	}

	// Works on both
	SRMT("mt13")
	mt13()

	if (chk0) {
		// Exceeded the depth supported on MS
		SRMT("mt14")
		mt14()
		SRMT("mt15")
		mt15()
	}

	if (chk0) {
		// ACPICA - AE_NOT_FOUND (it is correct), MS - Failure
		SRMT("mt16-0")
		mt16(0)
	}

	if (run0) {
		// Works on MS, AE_AML_OPERAND_TYPE on ACPICA
		SRMT("mt16-1")
		mt16(1)
		SRMT("mt16-2")
		mt16(2)
		SRMT("mt16-3")
		mt16(3)
	}

	if (chk0) {
		// ACPICA - AE_NOT_FOUND (it is correct), MS - Failure
		SRMT("mt17-0")
		mt17(0)
	}

	if (LAnd(chk0, run0)) {
		// Exceeded the depth supported on MS
		SRMT("mt17-1")
		mt17(1)
		SRMT("mt17-2")
		mt17(2)
	}

	SRMT("mt18-0")
	mt18(0)
	SRMT("mt18-1")
	mt18(1)
	SRMT("mt19-0")
	mt19(0)
	SRMT("mt19-1")
	mt19(1)
	SRMT("mt1a-0")
	mt1a(0)
	SRMT("mt1a-1")
	mt1a(1)
}

