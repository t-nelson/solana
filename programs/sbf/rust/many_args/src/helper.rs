//! Example Rust-based SBF program tests loop iteration

#![allow(clippy::arithmetic_side_effects)]

use solana_msg::msg;

pub fn many_args(
    arg1: u64,
    arg2: u64,
    arg3: u64,
    arg4: u64,
    arg5: u64,
    arg6: u64,
    arg7: u64,
    arg8: u64,
    arg9: u64,
) -> u64 {
    msg!("same package");
    msg!(
        "{:#x}, {:#x}, {:#x}, {:#x}, {:#x}",
        arg1,
        arg2,
        arg3,
        arg4,
        arg5
    );
    msg!(
        "{:#x}, {:#x}, {:#x}, {:#x}, {:#x}",
        arg6,
        arg7,
        arg8,
        arg9,
        0
    );
    arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8 + arg9
}
