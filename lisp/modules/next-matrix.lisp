; Get the coordinate from the first list of possibles
(defun get_coord_first_possible (matrix)
  (setf n (array-dimension matrix 0))
	(dotimes (i n)
    	(dotimes (j n)
    		(progn
                ;(print i)
                ;(print j)
                (setq current (aref matrix i j))
                (if (listp current)
                	(progn
                    ;(print "entrou")
                    (return-from get_coord_first_possible (list i j))
                  )
                )
            )	
    	)
    )
)

(defun copy-array (array &key
                   (element-type (array-element-type array))
                   (fill-pointer (and (array-has-fill-pointer-p array)
                                      (fill-pointer array)))
                   (adjustable (adjustable-array-p array)))
  (let ((dims (array-dimensions array)))
    ;; Dictionary entry for ADJUST-ARRAY requires adjusting a
    ;; displaced array to a non-displaced one to make a copy.
    (adjust-array
     (make-array dims
                 :element-type element-type :fill-pointer fill-pointer
                 :adjustable adjustable :displaced-to array)
     dims)))

(defun next_matrices (matrix)
	; (setq aux_list ())
  (clean_all matrix)
	(setq coord (get_coord_first_possible matrix))
	(setq i (car coord))
	(setq j (car (cdr coord)))
	(setq current (aref matrix i j))
	(setq m666 (copy-array matrix))
	(setq m2 (copy-array matrix))
	(setq to_fix (car current))
	(setq remainder (cdr current))
	(fix_value m666 i j to_fix)
	(fix_value m2 i j remainder)
	(list m666 m2)

)
