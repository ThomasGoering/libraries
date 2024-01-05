#! /usr/bin/env perl
# Copyright 2007-2021 The OpenSSL Project Authors. All Rights Reserved.
#
# Licensed under the Apache License 2.0 (the "License").  You may not use
# this file except in compliance with the License.  You can obtain a copy
# in the file LICENSE in the source distribution or at
# https://www.openssl.org/source/license.html


# ====================================================================
# Written by Andy Polyakov <appro@openssl.org> for the OpenSSL
# project. The module is, however, dual licensed under OpenSSL and
# CRYPTOGAMS licenses depending on where you obtain it. For further
# details see http://www.openssl.org/~appro/cryptogams/.
#
# Hardware SPARC T4 support by David S. Miller
# ====================================================================

# Performance improvement is not really impressive on pre-T1 CPU: +8%
# over Sun C and +25% over gcc [3.3]. While on T1, a.k.a. Niagara, it
# turned to be 40% faster than 64-bit code generated by Sun C 5.8 and
# >2x than 64-bit code generated by gcc 3.4. And there is a gimmick.
# X[16] vector is packed to 8 64-bit registers and as result nothing
# is spilled on stack. In addition input data is loaded in compact
# instruction sequence, thus minimizing the window when the code is
# subject to [inter-thread] cache-thrashing hazard. The goal is to
# ensure scalability on UltraSPARC T1, or rather to avoid decay when
# amount of active threads exceeds the number of physical cores.

# SPARC T4 SHA1 hardware achieves 3.72 cycles per byte, which is 3.1x
# faster than software. Multi-process benchmark saturates at 11x
# single-process result on 8-core processor, or ~9GBps per 2.85GHz
# socket.

$output=pop and open STDOUT,">$output";

@X=("%o0","%o1","%o2","%o3","%o4","%o5","%g1","%o7");
$rot1m="%g2";
$tmp64="%g3";
$Xi="%g4";
$A="%l0";
$B="%l1";
$C="%l2";
$D="%l3";
$E="%l4";
@V=($A,$B,$C,$D,$E);
$K_00_19="%l5";
$K_20_39="%l6";
$K_40_59="%l7";
$K_60_79="%g5";
@K=($K_00_19,$K_20_39,$K_40_59,$K_60_79);

$ctx="%i0";
$inp="%i1";
$len="%i2";
$tmp0="%i3";
$tmp1="%i4";
$tmp2="%i5";

sub BODY_00_15 {
my ($i,$a,$b,$c,$d,$e)=@_;
my $xi=($i&1)?@X[($i/2)%8]:$Xi;

$code.=<<___;
	sll	$a,5,$tmp0		!! $i
	add	@K[$i/20],$e,$e
	srl	$a,27,$tmp1
	add	$tmp0,$e,$e
	and	$c,$b,$tmp0
	add	$tmp1,$e,$e
	sll	$b,30,$tmp2
	andn	$d,$b,$tmp1
	srl	$b,2,$b
	or	$tmp1,$tmp0,$tmp1
	or	$tmp2,$b,$b
	add	$xi,$e,$e
___
if ($i&1 && $i<15) {
	$code.=
	"	srlx	@X[(($i+1)/2)%8],32,$Xi\n";
}
$code.=<<___;
	add	$tmp1,$e,$e
___
}

sub Xupdate {
my ($i,$a,$b,$c,$d,$e)=@_;
my $j=$i/2;

if ($i&1) {
$code.=<<___;
	sll	$a,5,$tmp0		!! $i
	add	@K[$i/20],$e,$e
	srl	$a,27,$tmp1
___
} else {
$code.=<<___;
	sllx	@X[($j+6)%8],32,$Xi	! Xupdate($i)
	xor	@X[($j+1)%8],@X[$j%8],@X[$j%8]
	srlx	@X[($j+7)%8],32,$tmp1
	xor	@X[($j+4)%8],@X[$j%8],@X[$j%8]
	sll	$a,5,$tmp0		!! $i
	or	$tmp1,$Xi,$Xi
	add	@K[$i/20],$e,$e		!!
	xor	$Xi,@X[$j%8],@X[$j%8]
	srlx	@X[$j%8],31,$Xi
	add	@X[$j%8],@X[$j%8],@X[$j%8]
	and	$Xi,$rot1m,$Xi
	andn	@X[$j%8],$rot1m,@X[$j%8]
	srl	$a,27,$tmp1		!!
	or	$Xi,@X[$j%8],@X[$j%8]
___
}
}

sub BODY_16_19 {
my ($i,$a,$b,$c,$d,$e)=@_;

	&Xupdate(@_);
    if ($i&1) {
	$xi=@X[($i/2)%8];
    } else {
	$xi=$Xi;
	$code.="\tsrlx	@X[($i/2)%8],32,$xi\n";
    }
$code.=<<___;
	add	$tmp0,$e,$e		!!
	and	$c,$b,$tmp0
	add	$tmp1,$e,$e
	sll	$b,30,$tmp2
	add	$xi,$e,$e
	andn	$d,$b,$tmp1
	srl	$b,2,$b
	or	$tmp1,$tmp0,$tmp1
	or	$tmp2,$b,$b
	add	$tmp1,$e,$e
___
}

sub BODY_20_39 {
my ($i,$a,$b,$c,$d,$e)=@_;
my $xi;
	&Xupdate(@_);
    if ($i&1) {
	$xi=@X[($i/2)%8];
    } else {
	$xi=$Xi;
	$code.="\tsrlx	@X[($i/2)%8],32,$xi\n";
    }
$code.=<<___;
	add	$tmp0,$e,$e		!!
	xor	$c,$b,$tmp0
	add	$tmp1,$e,$e
	sll	$b,30,$tmp2
	xor	$d,$tmp0,$tmp1
	srl	$b,2,$b
	add	$tmp1,$e,$e
	or	$tmp2,$b,$b
	add	$xi,$e,$e
___
}

sub BODY_40_59 {
my ($i,$a,$b,$c,$d,$e)=@_;
my $xi;
	&Xupdate(@_);
    if ($i&1) {
	$xi=@X[($i/2)%8];
    } else {
	$xi=$Xi;
	$code.="\tsrlx	@X[($i/2)%8],32,$xi\n";
    }
$code.=<<___;
	add	$tmp0,$e,$e		!!
	and	$c,$b,$tmp0
	add	$tmp1,$e,$e
	sll	$b,30,$tmp2
	or	$c,$b,$tmp1
	srl	$b,2,$b
	and	$d,$tmp1,$tmp1
	add	$xi,$e,$e
	or	$tmp1,$tmp0,$tmp1
	or	$tmp2,$b,$b
	add	$tmp1,$e,$e
___
}

$code.=<<___;
#ifndef __ASSEMBLER__
# define __ASSEMBLER__ 1
#endif
#include "crypto/sparc_arch.h"

#ifdef __arch64__
.register	%g2,#scratch
.register	%g3,#scratch
#endif

.section	".text",#alloc,#execinstr

#ifdef __PIC__
SPARC_PIC_THUNK(%g1)
#endif

.align	32
.globl	sha1_block_data_order
sha1_block_data_order:
	SPARC_LOAD_ADDRESS_LEAF(OPENSSL_sparcv9cap_P,%g1,%g5)
	ld	[%g1+4],%g1		! OPENSSL_sparcv9cap_P[1]

	andcc	%g1, CFR_SHA1, %g0
	be	.Lsoftware
	nop

	ld	[%o0 + 0x00], %f0	! load context
	ld	[%o0 + 0x04], %f1
	ld	[%o0 + 0x08], %f2
	andcc	%o1, 0x7, %g0
	ld	[%o0 + 0x0c], %f3
	bne,pn	%icc, .Lhwunaligned
	 ld	[%o0 + 0x10], %f4

.Lhw_loop:
	ldd	[%o1 + 0x00], %f8
	ldd	[%o1 + 0x08], %f10
	ldd	[%o1 + 0x10], %f12
	ldd	[%o1 + 0x18], %f14
	ldd	[%o1 + 0x20], %f16
	ldd	[%o1 + 0x28], %f18
	ldd	[%o1 + 0x30], %f20
	subcc	%o2, 1, %o2		! done yet?
	ldd	[%o1 + 0x38], %f22
	add	%o1, 0x40, %o1
	prefetch [%o1 + 63], 20

	.word	0x81b02820		! SHA1

	bne,pt	SIZE_T_CC, .Lhw_loop
	nop

.Lhwfinish:
	st	%f0, [%o0 + 0x00]	! store context
	st	%f1, [%o0 + 0x04]
	st	%f2, [%o0 + 0x08]
	st	%f3, [%o0 + 0x0c]
	retl
	st	%f4, [%o0 + 0x10]

.align	8
.Lhwunaligned:
	alignaddr %o1, %g0, %o1

	ldd	[%o1 + 0x00], %f10
.Lhwunaligned_loop:
	ldd	[%o1 + 0x08], %f12
	ldd	[%o1 + 0x10], %f14
	ldd	[%o1 + 0x18], %f16
	ldd	[%o1 + 0x20], %f18
	ldd	[%o1 + 0x28], %f20
	ldd	[%o1 + 0x30], %f22
	ldd	[%o1 + 0x38], %f24
	subcc	%o2, 1, %o2		! done yet?
	ldd	[%o1 + 0x40], %f26
	add	%o1, 0x40, %o1
	prefetch [%o1 + 63], 20

	faligndata %f10, %f12, %f8
	faligndata %f12, %f14, %f10
	faligndata %f14, %f16, %f12
	faligndata %f16, %f18, %f14
	faligndata %f18, %f20, %f16
	faligndata %f20, %f22, %f18
	faligndata %f22, %f24, %f20
	faligndata %f24, %f26, %f22

	.word	0x81b02820		! SHA1

	bne,pt	SIZE_T_CC, .Lhwunaligned_loop
	for	%f26, %f26, %f10	! %f10=%f26

	ba	.Lhwfinish
	nop

.align	16
.Lsoftware:
	save	%sp,-STACK_FRAME,%sp
	sllx	$len,6,$len
	add	$inp,$len,$len

	or	%g0,1,$rot1m
	sllx	$rot1m,32,$rot1m
	or	$rot1m,1,$rot1m

	ld	[$ctx+0],$A
	ld	[$ctx+4],$B
	ld	[$ctx+8],$C
	ld	[$ctx+12],$D
	ld	[$ctx+16],$E
	andn	$inp,7,$tmp0

	sethi	%hi(0x5a827999),$K_00_19
	or	$K_00_19,%lo(0x5a827999),$K_00_19
	sethi	%hi(0x6ed9eba1),$K_20_39
	or	$K_20_39,%lo(0x6ed9eba1),$K_20_39
	sethi	%hi(0x8f1bbcdc),$K_40_59
	or	$K_40_59,%lo(0x8f1bbcdc),$K_40_59
	sethi	%hi(0xca62c1d6),$K_60_79
	or	$K_60_79,%lo(0xca62c1d6),$K_60_79

.Lloop:
	ldx	[$tmp0+0],@X[0]
	ldx	[$tmp0+16],@X[2]
	ldx	[$tmp0+32],@X[4]
	ldx	[$tmp0+48],@X[6]
	and	$inp,7,$tmp1
	ldx	[$tmp0+8],@X[1]
	sll	$tmp1,3,$tmp1
	ldx	[$tmp0+24],@X[3]
	subcc	%g0,$tmp1,$tmp2	! should be 64-$tmp1, but -$tmp1 works too
	ldx	[$tmp0+40],@X[5]
	bz,pt	%icc,.Laligned
	ldx	[$tmp0+56],@X[7]

	sllx	@X[0],$tmp1,@X[0]
	ldx	[$tmp0+64],$tmp64
___
for($i=0;$i<7;$i++)
{   $code.=<<___;
	srlx	@X[$i+1],$tmp2,$Xi
	sllx	@X[$i+1],$tmp1,@X[$i+1]
	or	$Xi,@X[$i],@X[$i]
___
}
$code.=<<___;
	srlx	$tmp64,$tmp2,$tmp64
	or	$tmp64,@X[7],@X[7]
.Laligned:
	srlx	@X[0],32,$Xi
___
for ($i=0;$i<16;$i++)	{ &BODY_00_15($i,@V); unshift(@V,pop(@V)); }
for (;$i<20;$i++)	{ &BODY_16_19($i,@V); unshift(@V,pop(@V)); }
for (;$i<40;$i++)	{ &BODY_20_39($i,@V); unshift(@V,pop(@V)); }
for (;$i<60;$i++)	{ &BODY_40_59($i,@V); unshift(@V,pop(@V)); }
for (;$i<80;$i++)	{ &BODY_20_39($i,@V); unshift(@V,pop(@V)); }
$code.=<<___;

	ld	[$ctx+0],@X[0]
	ld	[$ctx+4],@X[1]
	ld	[$ctx+8],@X[2]
	ld	[$ctx+12],@X[3]
	add	$inp,64,$inp
	ld	[$ctx+16],@X[4]
	cmp	$inp,$len

	add	$A,@X[0],$A
	st	$A,[$ctx+0]
	add	$B,@X[1],$B
	st	$B,[$ctx+4]
	add	$C,@X[2],$C
	st	$C,[$ctx+8]
	add	$D,@X[3],$D
	st	$D,[$ctx+12]
	add	$E,@X[4],$E
	st	$E,[$ctx+16]

	bne	SIZE_T_CC,.Lloop
	andn	$inp,7,$tmp0

	ret
	restore
.type	sha1_block_data_order,#function
.size	sha1_block_data_order,(.-sha1_block_data_order)
.asciz	"SHA1 block transform for SPARCv9, CRYPTOGAMS by <appro\@openssl.org>"
.align	4
___

# Purpose of these subroutines is to explicitly encode VIS instructions,
# so that one can compile the module without having to specify VIS
# extensions on compiler command line, e.g. -xarch=v9 vs. -xarch=v9a.
# Idea is to reserve for option to produce "universal" binary and let
# programmer detect if current CPU is VIS capable at run-time.
sub unvis {
my ($mnemonic,$rs1,$rs2,$rd)=@_;
my $ref,$opf;
my %visopf = (	"faligndata"	=> 0x048,
		"for"		=> 0x07c	);

    $ref = "$mnemonic\t$rs1,$rs2,$rd";

    if ($opf=$visopf{$mnemonic}) {
	foreach ($rs1,$rs2,$rd) {
	    return $ref if (!/%f([0-9]{1,2})/);
	    $_=$1;
	    if ($1>=32) {
		return $ref if ($1&1);
		# re-encode for upper double register addressing
		$_=($1|$1>>5)&31;
	    }
	}

	return	sprintf ".word\t0x%08x !%s",
			0x81b00000|$rd<<25|$rs1<<14|$opf<<5|$rs2,
			$ref;
    } else {
	return $ref;
    }
}
sub unalignaddr {
my ($mnemonic,$rs1,$rs2,$rd)=@_;
my %bias = ( "g" => 0, "o" => 8, "l" => 16, "i" => 24 );
my $ref="$mnemonic\t$rs1,$rs2,$rd";

    foreach ($rs1,$rs2,$rd) {
	if (/%([goli])([0-7])/)	{ $_=$bias{$1}+$2; }
	else			{ return $ref; }
    }
    return  sprintf ".word\t0x%08x !%s",
		    0x81b00300|$rd<<25|$rs1<<14|$rs2,
		    $ref;
}

foreach (split("\n",$code)) {
	s/\`([^\`]*)\`/eval $1/ge;

	s/\b(f[^\s]*)\s+(%f[0-9]{1,2}),\s*(%f[0-9]{1,2}),\s*(%f[0-9]{1,2})/
		&unvis($1,$2,$3,$4)
	 /ge;
	s/\b(alignaddr)\s+(%[goli][0-7]),\s*(%[goli][0-7]),\s*(%[goli][0-7])/
		&unalignaddr($1,$2,$3,$4)
	 /ge;

	print $_,"\n";
}

close STDOUT or die "error closing STDOUT: $!";
