# Author: peppe8o
# Blog: https://peppe8o.com
# Date: Aug 26th, 2021
# Version: 1.0

# Using a 8 segment LED status bar with the 8 LEDs
# connected to output pins 0-7 of a hc595n shift register,
# this program will turn on/off LEDs.

from machine import Pin
import utime

class Led_bar_8_segment:

  def __init__(self, data_pin=13, latch_pin=15, clock_pin=14):
    print("Initializing 8 segment LED bar:")  
    print("Data Pin:  ", data_pin)
    print("Latch Pin: ", latch_pin)
    print("Clock Pin: ", clock_pin)
    self.dataPIN = Pin(data_pin, Pin.OUT)
    self.latchPIN = Pin(latch_pin, Pin.OUT)
    self.clockPIN = Pin(clock_pin, Pin.OUT)
    self.current_data = "11111111" #off

    
  def refresh(self, new_data): 

    #put latch down to start data sending
    self.clockPIN.value(0)
    self.latchPIN.value(0)
    self.clockPIN.value(1)
  
      #load data in reverse order
    for i in range(7, -1, -1):
      self.clockPIN.value(0)
      self.dataPIN.value(int(new_data[i]))
      self.clockPIN.value(1)
    #put latch up to store data on register
    self.clockPIN.value(0)
    self.latchPIN.value(1)
    self.clockPIN.value(1)
    self.current_data = new_data

  # i = 0 to 8  
  def light_up_to(self, i):
    self.refresh("1" * (i) + "0" * (8-i))
    
  def on(self, i):
    self.current_data[i] = "0"
    self.refresh() 
             
  def off(self, i):
    self.current_data[i] = "1"
    self.refresh()       
  
  def toggle(self, i):
    self.current_data[i] = "0" if self.current_data[i] == "1" else "1"
    self.refresh()


led = Led_bar_8_segment()
led.light_up_to(0)



for i in range(0, 9):
  led.light_up_to(i)
  print(i)
  print(led.current_data)
  utime.sleep(1)
   


    


