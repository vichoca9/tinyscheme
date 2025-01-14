# Tinyscheme
A R5RS *tiny* implementation. Only dependencies are C and optional 
math and readline libraries.

## How to build
Run `make`, see BUILDING or `scheme.h` for more options. By default,
tinyscheme uses `float complex` for complex numbers; add
`-DUSE_DOUBLE_COMPLEX=1` to compile options if 
you want `double complex` instead.

Run `make indent` for auto code formatting. Not mandatory, but helps
with standarization for editors.

## Implementation details
- [X] Readline support
- [ ] Readline: multiline support (see Lua or Python)
- [X] Full complex math as in the spec (needs TESTING)
- [ ] Higienic macros
- [ ] Full compliant with R5RS
