#functions to transform disease severity rating (DSR) according to
# Fang et al. (2011) to a normal scale:
dsr2normal <- function(dsr) {
  (dsr^1.5 + 1)  / 1.5
}

#back-transform normalized values to fang scale.
normal2dsr <- function(dsr) {
  ((dsr * 1.5) - 1)^ (1 / 1.5)
  }
