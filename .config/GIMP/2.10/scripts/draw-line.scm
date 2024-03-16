(define (script-fu-draw-line image drawable x1 y1 x2 y2)
  (gimp-context-push)
  (gimp-context-set-foreground (car (gimp-palette-get-color 0)))
  (gimp-drawable-set-ink drawable INK-PAINT)
  (gimp-drawable-set-opacity drawable 100)
  (gimp-drawable-set-mode drawable LAYER-MODE-NORMAL)
  (gimp-image-undo-group-start image)
  (gimp-edit-stroke drawable)
  (gimp-image-undo-group-end image)
  (gimp-displays-flush)
  (gimp-context-pop)
)

(script-fu-register
  "script-fu-draw-line"
  "Draw Line"
  "Draws a line between two points"
  "Author"
  "Copyright"
  "Date"
  ""
  SF-IMAGE      "Image"      0
  SF-DRAWABLE   "Drawable"   0
  SF-ADJUSTMENT "X1"         '(0 0 10000 1 10 0 1)
  SF-ADJUSTMENT "Y1"         '(0 0 10000 1 10 0 1)
  SF-ADJUSTMENT "X2"         '(0 0 10000 1 10 0 1)
  SF-ADJUSTMENT "Y2"         '(0 0 10000 1 10 0 1)
)

(script-fu-menu-register "script-fu-draw-line" "<Image>/Filters/Draw Line")
