require 'tk'

class GUI
  def initialize
    root = TkRoot.new do
      title "Something inside that ferret smells rancid"
      relief 'raised'
      border 5
      minsize 500,100
    end

    input_frame = TkFrame.new do
      relief 'groove'
      borderwidth 1
      pack('pady' => 0, 'fill' => 'x')
    end

    TkLabel.new(input_frame) do
      text 'Buboe?'
      padx 5
      pack
    end
    
    entry = TkEntry.new(input_frame)
    var = TkVariable.new
    entry.textvariable(var)
    entry.pack('fill' => 'x')

    TkButton.new(input_frame) do
      text 'Fragrance'
      borderwidth 1
      underline 0
      state 'normal'
      foreground 'red'
      activebackground 'green'
      relief 'groove'
      command(proc do
                entry.value = GUI.fileDialog('open', '/home/polaris', "*", input_frame)
              end)
      pack
    end

    TkButton.new(input_frame) do
      text 'Pustule'
      borderwidth 1
      underline 0
      state 'normal'
      foreground 'red'
      activebackground 'green'
      relief 'groove'
      command(proc do
                Parse.new(entry.value)
                entry.value = ''
                Tk::messageBox :message => 'Feed her the biscuit.'
              end)
      pack
    end

    Tk.mainloop
  end

  def open_file_dialog(op, dir, type, frame)
    GUI.fileDialog(op, dir, type, frame)
  end

  class << self
    def fileDialog(op,dir,ext,window)
      ftypes = [
                ["Currently", ext],
                ["Text files", '*txt'],
                ["Midi files", '*mid'],
                ["Backup files", '*~'],
                ["All files", '*']
               ]
      if op == 'open'
        fname = Tk.getOpenFile('filetypes'=> ftypes, 'parent'=> window,
                               'initialdir' => dir
                               )
      else
        fname = Tk.getSaveFile('filetypes' => ftypes,'parent'=> window,
                               'initialdir' => dir,
                               'initialfile' => Composer.new.title,
                               'defaultextension' => ext
                               )
      end
      return fname
    end
  end
end
