;; Controller assayrun definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller assayrun) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))


(assayrun-define getforpsid
(lambda (rc)
  (let* ((ret #f)
	(holder '())
	(dummy (dbi-query ciccio (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND plate_set_id =" id )))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))))
	(body (string-concatenate (prep-ar-rows holder))))
    (view-render "getforpsid" (the-environment))
    ))

(assayrun-define gethlforarid
  (lambda (rc)
  "<h1>This is assayrun#getid</h1><p>Find me in app/views/assayrun/getid.html.tpl</p>"
  ;; TODO: add controller method `getid'
  ;; uncomment this line if you want to render view from template
   (view-render "gethlforarid" (the-environment))
  ))
