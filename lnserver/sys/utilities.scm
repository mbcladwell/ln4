(define-module (lnserver sys utilities)
  #:export (get-rand-file-name
	    ciccio
	    sid
	    help-url
	    prep-plt-rows
	    prep-ar-rows
	    prep-lyt-rows
	    get-plates-for-psid
	    get-assay-runs-for-psid
	    get-all-layouts
	    get-layout-for-id
	    prep-lyt-for-r
	    get-layout-table-for-r
	    get-data-for-layout
	    get-format-for-layout-id
	    get-c1
	    get-c2
	    get-c3
	    get-c4
	    get-c5
	    get-c6
	    get-c7
	    get-c8
	    get-c9
	    get-c10
	    get-c11
	    get-c12
	    get-c13
	    get-c14
	    get-c15
	    get-c16
	    get-c17
	    ))

(use-modules (artanis artanis)(artanis utils) (ice-9 local-eval) (srfi srfi-1)
             (artanis irregex)(dbi dbi) (ice-9 textual-ports)(ice-9 rdelim))

;; artanis config: /etc/artanis/artanis.conf
;; pgbouncer -d ./syncd/pgbouncer.ini
;; psql -U ln_admin -p 6432 -d pgbouncer -h 127.0.0.1
;; psql -U ln_admin -p 6432 -d lndb -h 127.0.0.1
;; guix environment --manifest=./environment.scm --pure
;; guile -s ./lnserver.scm

;; https://github.com/UMCUGenetics/guix-documentation/blob/master/for-bioinformaticians/guix-for-bioinformaticians.md

(define file (open-input-file "/home/mbc/projects/ln4/limsnucleus.properties"))
(display (read-line file))


(define help-url "www.labsolns.com/software/")

;; session id
(define sid "1")

(define (get-rand-file-name pre suff)
  (string-append "tmp/" pre "-" (number->string (random 10000000000000000000000)) "." suff))


(define ciccio (dbi-open "postgresql" "ln_admin:welcome:lndb:socket:192.168.1.11:5432"))


;; artanis result-ref only works with strings
;; get a numeric by column and convert to string
(define (get-c1 x) (number->string (cdar x)))
(define (get-c2 x) (number->string (cdar (cdr x))))
(define (get-c3 x) (number->string (cdar (cddr x))))
(define (get-c4 x) (number->string (cdar (cdddr x))))
(define (get-c5 x) (number->string (cdar (cddddr x))))
(define (get-c6 x) (number->string (cdar (cdr (cddddr x)))))
(define (get-c7 x) (number->string (cdar (cddr (cddddr x)))))
(define (get-c8 x) (number->string (cdar (cdddr (cddddr x)))))
(define (get-c9 x) (number->string (cdar (cddddr (cddddr x)))))
(define (get-c10 x) (number->string (cdar (cdr (cddddr (cddddr x))))))
(define (get-c11 x) (number->string (cdar (cddr (cddddr (cddddr x))))))
(define (get-c12 x) (number->string (cdar (cdddr (cddddr (cddddr x))))))
(define (get-c13 x) (number->string (cdar (cddddr (cddddr (cddddr x))))))
(define (get-c14 x) (number->string (cdar (cdr (cddddr (cddddr (cddddr x)))))))
(define (get-c15 x) (number->string (cdar (cddr (cddddr (cddddr (cddddr x)))))))
(define (get-c16 x) (number->string (cdar (cdddr (cddddr (cddddr (cddddr x)))))))
(define (get-c17 x) (number->string (cdar (cddddr (cddddr (cddddr (cddddr x)))))))




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






(define (get-all-layouts)
  (let* ((ret #f)
	 (holder '())
	 (help-link "localhost:4000/software/layouts")
	 (help-text "Help for Layouts")
	(table-header "<table><caption><h1>Plate Layouts</h1></caption><tr><th>ID</th><th>Name</th><th>Description</th><th>Format</th><th>Sample N</th><th>Target N</th><th>Edge?</th><th>N Controls</th><th>Unk N</th><th>Location</th><th>src/dest</th></tr>")
	(dummy (dbi-query ciccio  "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name"))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio))
		  ))
	(body (string-concatenate (prep-lyt-rows holder))))
    (string-append table-header body "</table>")))
















