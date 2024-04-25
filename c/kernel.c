void kernel_main() {
  char *VIDEO_BUFFER = (char *)0xb8000;
  *VIDEO_BUFFER = 'X';
}
