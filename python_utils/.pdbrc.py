import pdb


class Config(pdb.DefaultConfig):
    filename_color = pdb.Color.lightgray
    use_terminal256formatter = False

    def __init__(self):

        try:
            from pygments.formatters import terminal
        except ImportError:
            pass
        else:
            self.colorscheme = terminal.TERMINAL_COLORS.copy()
            self.colorscheme.update(
                {
                    terminal.Keyword: ("darkred", "red"),
                    terminal.Number: ("darkyellow", "yellow"),
                    terminal.String: ("brown", "green"),
                    terminal.Name.Function: ("darkgreen", "blue"),
                    terminal.Name.Namespace: ("teal", "turquoise"),
                }
            )

    def setup(self, pdb):
        Pdb = pdb.__class__
        # make 'l' an alias to 'longlist'
        Pdb.do_l = Pdb.do_longlist
        # make 'st' an alias to 'sticky'
        Pdb.do_st = Pdb.do_sticky
