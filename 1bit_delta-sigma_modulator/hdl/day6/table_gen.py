import numpy as np
import matplotlib.pyplot as plt
#import csv


if __name__ == "__main__":
    x = np.linspace(0, np.pi/2, 256);
    y = (np.sin(x)*511).round().astype(np.int64)

    with open("sin_table.txt", "w") as f:
        for n in y:
            print("{0:0>10b}".format(n & 0b1111111111, 'b'))
            f.write("{0:0>10b}\r\n".format(n & 0b1111111111, 'b'))

    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.plot(x, y, ls = '--', color='k')
    ax.set_xlabel('Omega')
    ax.set_ylabel('Amp')
    ax.grid(ls='--')
    fig.tight_layout()
    plt.show()
