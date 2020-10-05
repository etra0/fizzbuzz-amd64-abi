#[link(name = "fizz")]
extern "C" {
    fn detect_fizz_buzz(v: u32);
}
fn main() {
    println!("This is being called from Rust");
    unsafe {
        detect_fizz_buzz(15);
    }
}
