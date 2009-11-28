#define PERL_NO_GET_CONTEXT
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

#define NEED_newSVpvn_flags
#include "ppport.h"

#ifndef newSVpvs_share
#define newSVpvs_share(s) Perl_newSVpvn_share(aTHX_ s, sizeof(s)-1, 0U)
#endif

static SV*
mx_ma_get_name(pTHX) {
    STRLEN len;
    const char* name = SvPV_const(PL_subname, len);

    I32 pos = len;

    while(pos > 0){
        if(name[--pos] == ':'){
            I32 const distance = len - pos - 1;
            return newSVpvn_flags(name + len - distance, distance, SVs_TEMP);
        }
    }
    return newSVpvn_flags(name, pos, SVs_TEMP);
}

static SV*
mx_ma_get_meta(pTHX_ SV* const klass) {
    dSP;
    SV* meta;

    PUSHMARK(SP);
    EXTEND(SP, 3);
    mPUSHs(newSVpvs_share("MouseX::MethodAttributes"));
    mPUSHs(newSVpvs_share("for_class"));
    PUSHs(klass);
    PUTBACK;
    call_method("init_meta", G_VOID | G_DISCARD);

    SPAGAIN;

    PUSHMARK(SP);
    XPUSHs(klass);
    PUTBACK;
    call_method("meta", G_SCALAR);
    SPAGAIN;
    meta = POPs;
    PUTBACK;

    return meta;
}

MODULE = MouseX::MethodAttributes	PACKAGE = MouseX::MethodAttributes::Role::AttrContainer

PROTOTYPES: DISABLE

void
MODIFY_CODE_ATTRIBUTES(SV* klass, code, ...)
CODE:
{
    SV* const name = mx_ma_get_name(aTHX);
    SV* const meta = mx_ma_get_meta(aTHX_ klass);
    I32 i;

    PUSHMARK(SP);
    EXTEND(SP, items);
    PUSHs(meta);
    PUSHs(name);
    for(i = 2; i < items; i++){
        PUSHs(ST(i));
    }
    PUTBACK;
    call_method("register_method_attributes", G_VOID | G_DISCARD);
}
