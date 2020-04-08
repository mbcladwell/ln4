;; Controller plate definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plate) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys utilities))

(define (prep-plt-rows a)
  (fold (lambda (x prev)
          (let (
                (plate-sys-name (result-ref x "plate_sys_name"))
		(barcode  (result-ref x "barcode") ))
            (cons (string-append "<tr><th><a href=\"localhost:3000/plate/getwellsforplt?id=" (number->string (cdr (car x))) "\">" plate-sys-name "</a></th><th>" barcode  "</th></tr>")
		  prev)))
        '() a))


(define (prep-ar-rows a)
  (fold (lambda (x prev)
          (let (
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
		(assay-run-name (result-ref x "assay_run_name"))
		(descr (result-ref x "descr"))
		(assay-type-name (result-ref x "assay_type_name"))
		(sys-name (result-ref x "sys_name"))
		(name (result-ref x "name"))
		)
            (cons (string-append "<tr><th><a href=\"localhost:3000/assayrun/getid?id="  (number->string (cdr (car x))) "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" descr "</th><th>" assay-type-name "</th><th>" sys-name "</th><th>" name "</th><tr>")
		  prev)))
        '() a))



(plate-define getpltforps
  (lambda (rc)
 (let* ((ret #f)
	(holder '())
	(help-topic "plate")
	(id  (get-from-qstr rc "id"))
	(dummy (dbi-query ciccio (string-append "select plate_plate_set.plate_id, plate.plate_sys_name, plate.barcode from plate, plate_plate_set where plate_plate_set.plate_id=plate.id AND plate_plate_set.plate_set_id =" id )))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))))
	(body (string-concatenate (prep-plt-rows holder)))
	(ret2 #f)
	(holder2 '())
	(dummy3 (dbi-query ciccio (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND plate_set_id =" id )))
	(ret2 (dbi-get_row ciccio))
	(dummy4 (while (not (equal? ret2 #f))     
		  (set! holder2 (cons ret2 holder2))		   
		  (set! ret2  (dbi-get_row ciccio))))
	(body2 (string-concatenate (prep-ar-rows holder2))))
   (view-render "getpltforps" (the-environment)))))

