using Metatheory
using Test
using MTMaths

Metatheory.options[:verbose] = true
Metatheory.options[:printiter] = true

@metatheory_init ()


@test :(4a)         == @simplify 2a + a + a
@test :(a*b*c)      == @simplify a * c * b
@test :(2x)         == @simplify 1 * x * 2
@test :((a*b)^2)    == @simplify (a*b)^2
@test :((a*b)^6)    == @simplify (a^2*b^2)^3
@test :(a+b+d)      == @simplify a + b + (0*c) + d
@test :(a+b)        == @simplify a + b + (c*0) + d - d
@test :(a)          == @simplify (a + d) - d
@test :(a + b + d)  == @simplify a + b * c^0 + d
@test :(a * b * x ^ (d+y))  == @simplify a * x^y * b * x^d
@test :(a * b * x ^ 74103)  == @simplify a * x^(12 + 3) * b * x^(42^3)

@test 1 == @simplify (x+y)^(a*0) / (y+x)^0
@test 2 == @simplify cos(x)^2 + 1 + sin(x)^2
@test 2 == @simplify cos(y)^2 + 1 + sin(y)^2
@test 2 == @simplify sin(y)^2 + cos(y)^2 + 1

@test :(y + sec(x)^2 ) == @simplify 1 + y + tan(x)^2
@test :(y + csc(x)^2 ) == @simplify 1 + y + cot(x)^2
