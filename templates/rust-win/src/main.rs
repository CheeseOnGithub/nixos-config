use windows::core::PCSTR;
use windows::Win32::UI::WindowsAndMessaging::{MessageBoxA, MB_OK};

fn main() {
    unsafe {
        let text = PCSTR(b"rustMate\0".as_ptr());
        let title = PCSTR(b"rust\0".as_ptr());
        let _ = MessageBoxA(None, text, title, MB_OK);
    }
}
