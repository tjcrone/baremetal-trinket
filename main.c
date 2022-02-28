#include "samd21e18a.h"

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
  PORT->Group[0].DIR.reg |= PORT_PA10;        // pin PA10 is output
}

void blink(void) {
  PORT->Group[0].OUT.reg |= PORT_PA10;        // pin high
  for (int i = 0 ; i < 100000; i++);          // delay
  PORT->Group[0].OUT.reg &= ~(PORT_PA10);     // pin low
  for (int i = 0 ; i < 100000; i++);
}