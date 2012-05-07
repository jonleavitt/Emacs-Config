;; AUCTeX configuration
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;;added by jon
(load "preview-latex.el" nil t t)


(setq-default TeX-master nil)

;; use pdflatex
(setq TeX-PDF-mode t)

(setq TeX-view-program-selection
      '((output-dvi "DVI Viewer")
        (output-pdf "PDF Viewer")
        (output-html "HTML Viewer")))
;; this section is good for OS X only
;; TODO add sensible defaults for Linux/Windows
(setq TeX-view-program-list
      '(("DVI Viewer" "open %o")
        ("PDF Viewer" "open %o")
        ("HTML Viewer" "open %o")))

(defun prelude-latex-mode-hook ()
  (turn-on-auto-fill)
  (abbrev-mode +1))

(add-hook 'LaTeX-mode-hook 'prelude-latex-mode-hook)

(provide 'prelude-latex)

;;; prelude-latex.el ends here
