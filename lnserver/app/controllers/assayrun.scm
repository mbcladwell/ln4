;; Controller assayrun definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller assayrun) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))


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
            (cons (string-append "<tr><th><a href=\"localhost:3000/gethlforar?id=" (number->string (cdr (car x))) "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" descr "</th><th>" assay-type-name "</th><th>" sys-name "</th><th>" name "</th><tr>")
		  prev)))
        '() a))



(define (get-assay-runs-for-psid id)
  (let* ((ret #f)
	(holder '())
	(table-header (string-append "<table><caption><h1>Assay Runs for PS-" id "</h1></caption><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr>"))
	(dummy (dbi-query ciccio (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND plate_set_id =" id )))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))))
	(body (string-concatenate (prep-ar-rows holder))))
    (string-append table-header body "</table>")))


(assayrun-define getid
  (lambda (rc)
  "<h1>This is assayrun#getid</h1><p>Find me in app/views/assayrun/getid.html.tpl</p>"
  ;; TODO: add controller method `getid'
  ;; uncomment this line if you want to render view from template
   (view-render "getid" (the-environment))
  ))

(assayrun-define gethlid
  (lambda (rc)
  "<h1>This is assayrun#getid</h1><p>Find me in app/views/assayrun/getid.html.tpl</p>"
  ;; TODO: add controller method `getid'
  ;; uncomment this line if you want to render view from template
   (view-render "getid" (the-environment))
  ))
