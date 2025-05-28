import tkinter as tk
import time

# Create a fullscreen white window
root = tk.Tk()
root.title('flashbang')
root.attributes('-fullscreen', True)
root.attributes('-topmost', True)
root.configure(bg='white')
root.attributes('-alpha', 1.0)  # Fully opaque

# Gradually reduce opacity
def fade_out():
    alpha = 1.0
    step = 0.05
    delay = 0.01  # seconds between steps

    while alpha > 0:
        alpha -= step
        root.attributes('-alpha', alpha)
        root.update()
        time.sleep(delay)
    root.destroy()

root.after(10, fade_out)
root.mainloop()
