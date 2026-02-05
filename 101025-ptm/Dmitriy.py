import os
import time

def clear_screen():
    os.system("cls" if os.name == "nt" else "clear")

frames = [
    r"""
     o
    /|\
    / \
    """,
    r"""
     o
    /|\
     |
    """,
    r"""
     o
     |
    / \
    """,
]

def jump(repeats=5, delay=0.3):
    for _ in range(repeats):
        for frame in frames + frames[::-1]:
            clear_screen()
            print("\n" * 5)
            print(frame)
            time.sleep(delay)

if __name__ == "__main__":
    jump()
