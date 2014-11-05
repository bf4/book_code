import tkinter

class Counter:
    """A simple counter GUI using object-oriented programming."""
    def __init__(self, parent):
	
        """Create the GUI."""
		
        # Framework.
        self.parent = parent
        self.frame = tkinter.Frame(parent)
        self.frame.pack()
		
        # Model.
        self.state = tkinter.IntVar()
        self.state.set(1)
		
        # Label displaying current state.
        self.label = tkinter.Label(self.frame, textvariable=self.state)
        self.label.pack()
		
        # Buttons to control application.
        self.up = tkinter.Button(self.frame, text='up', command=self.up_click)
        self.up.pack(side='left')

        self.right = tkinter.Button(self.frame, text='quit',
                                    command=self.quit_click)
        self.right.pack(side='left')

    def up_click(self):
        """Handle click on 'up' button."""
		
        self.state.set(self.state.get() + 1)

		
    def quit_click(self):
        """Handle click on 'quit' button."""
		
        self.parent.destroy()
if __name__ == '__main__':

    window = tkinter.Tk()
    myapp = Counter(window)
    window.mainloop()
