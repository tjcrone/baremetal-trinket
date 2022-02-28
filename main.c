#include "samd21.h"

void port_init(void);
void blink(void);

int main(void)
{
  SystemInit();
  port_init();

  while (1) {
    blink(); 
  }
}

void port_init(void) {
  REG_PORT_DIR0 |= PORT_PA10;
}

void blink(void) {
  REG_PORT_OUT0 |= PORT_PA10;
  for (int i = 0 ; i < 100000; i++);
  REG_PORT_OUT0 &= ~(PORT_PA10);
  for (int i = 0 ; i < 100000; i++);
}
