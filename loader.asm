start:
    jmp .init

.entrypoint:
    mov si, text_string
    call print_string

    jmp $

.init:
    mov ax, 07C0h
    add ax, 288
    mov ss, ax
    mov sp, 4096
    mov ax, 07C0h
    mov ds, ax

    jmp .entrypoint

print_string:
    mov ah, 0Eh

.repeat:
    lodsb

    cmp al, 0
    je .done

    int 10h
    jmp .repeat

.done:
    ret

text_string      db 'TextString', 0
times 510-($-$$) db 0
                 dw 0xAA55
