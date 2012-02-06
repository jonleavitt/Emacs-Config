;;indents the whole buffer
(defun ib ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;;put all buffers in one window
(setq ns-pop-up-frames nil)

;;allows sublime text-like autocompletions
(require 'cl)
(defvar my-abbrev-tables nil)
(defun my-abbrev-hook ()
  (let ((def (assoc (symbol-name last-abbrev) my-abbrev-tables)))
    (when def
      (execute-kbd-macro (cdr def)))
    t))
(put 'my-abbrev-hook 'no-self-insert t)
(defmacro declare-abbrevs (table abbrevs)
  (if (consp table)
      `(progn ,@(loop for tab in table
                      collect `(declare-abbrevs ,tab ,abbrevs)))
    `(progn
       ,@(loop for abbr in abbrevs
               do (when (third abbr)
                    (push (cons (first abbr) (read-kbd-macro (third abbr)))
                          my-abbrev-tables))
               collect `(define-abbrev ,table
                          ,(first abbr) ,(second abbr) ,(and (third abbr)
                                                             ''my-abbrev-hook))))))
(put 'declare-abbrevs 'lisp-indent-function 2)

(autoload 'expand-abbrev-hook "expand")
(define-abbrev-table 'java-mode-abbrev-table'(
                                             ("sout" ["System.out.println(\"\");" 3 () nil] expand-abbrev-hook 0)
                                             ("psvm" ["public static void main(String args[]){\n\n}" 2 () nil] expand-abbrev-hook 0)))

;;show line numbers
(global-linum-mode 1)

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(server-start)
