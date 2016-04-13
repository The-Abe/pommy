require 'pommy/version'
require 'curses'

module Pommy

  module_function

  def init_curses
    Curses.init_screen
    Curses.start_color
    Curses.curs_set(0)
    Curses.init_pair(Curses::COLOR_GREEN,Curses::COLOR_WHITE,Curses::COLOR_GREEN) 
    Curses.init_pair(Curses::COLOR_RED,Curses::COLOR_WHITE,Curses::COLOR_RED)
  end

  def reset_screen
    Curses.clear
    Curses.setpos(0,0)
  end

  def get_size
    return { width: Curses.cols, height: Curses.lines }
  end

  def draw_bar(percentage, text)
    width = Pommy::get_size[:width]
    negative_percentage = 100.0 - percentage
    done_blocks = (negative_percentage/100.0*width).round
    undone_blocks = width-done_blocks
    green_text = text[0,done_blocks]
    red_text = text[-(text.length - done_blocks),( text.length - done_blocks)] || ""
    done_blocks = done_blocks - green_text.length
    done_blocks = 0 if done_blocks < 0
    undone_blocks = undone_blocks - red_text.length
    undone_blocks = 0 if undone_blocks < 0
    Curses.attron(Curses.color_pair(Curses::COLOR_GREEN)|Curses::A_BOLD){
      Curses.addstr "#{green_text}#{" "*done_blocks}"
    }
    Curses.attron(Curses.color_pair(Curses::COLOR_RED)|Curses::A_BOLD){
      Curses.addstr "#{red_text}#{" "*undone_blocks}"
    }
  end

  def run(pomodoro_length)
    Pommy.init_curses
    now = Time.now
    future = now + pomodoro_length.to_f*60
    while now < future
      now = Time.now
      difference = future - now
      difference = 0 if difference < 0
      minutes = (difference/60).to_i
      seconds = (difference%60).ceil
      seconds = "0#{seconds}" if seconds < 10
      percentage = (difference/(pomodoro_length.to_f*60/100))
      negative_percentage = 100 - percentage
      text = "#{"%3.2f" % negative_percentage}% #{minutes}:#{seconds}"
      Pommy.reset_screen
      Curses.addstr 'Pommy'
      Curses.setpos(2,0)
      Pommy.draw_bar(percentage, text)
      Curses.refresh
      sleep(0.1)
    end
    Curses.setpos(3,0)
    Curses.addstr 'Pommy ended. Press a key to close the screen.'
    Curses.refresh
    Curses.getch
  end
end
