(require 'imenu)

(defun prelude-ido-goto-symbol (&optional symbol-list)
  "Refresh imenu and jump to a place in the buffer using Ido."
  (interactive)
  (unless (featurep 'imenu)
	(require 'imenu nil t))
  (cond
   ((not symbol-list)
	(let ((ido-mode ido-mode)
		  (ido-enable-flex-matching
		   (if (boundp 'ido-enable-flex-matching)
			   ido-enable-flex-matching t))
		  name-and-pos symbol-names position)
	  (unless ido-mode
		(ido-mode 1)
		(setq ido-enable-flex-matching t))
	  (while (progn
			   (imenu--cleanup)
			   (setq imenu--index-alist nil)
			   (prelude-ido-goto-symbol (imenu--make-index-alist))
			   (setq selected-symbol
					 (ido-completing-read "Symbol? " symbol-names))
			   (string= (car imenu--rescan-item) selected-symbol)))
	  (unless (and (boundp 'mark-active) mark-active)
		(push-mark nil t nil))
	  (setq position (cdr (assoc selected-symbol name-and-pos)))
	  (cond
	   ((overlayp position)
		(goto-char (overlay-start position)))
	   (t
		(goto-char position)))))
   ((listp symbol-list)
	(dolist (symbol symbol-list)
	  (let (name position)
		(cond
		 ((and (listp symbol) (imenu--subalist-p symbol))
		  (prelude-ido-goto-symbol symbol))
		 ((listp symbol)
		  (setq name (car symbol))
		  (setq position (cdr symbol)))
		 ((stringp symbol)
		  (setq name symbol)
		  (setq position
				(get-text-property 1 'org-imenu-marker symbol))))
		(unless (or (null position) (null name)
					(string= (car imenu--rescan-item) name))
		  (add-to-list 'symbol-names name)
		  (add-to-list 'name-and-pos (cons name position))))))))

(defun prelude-local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t)
  (auto-fill-mode t))

(defun prelude-add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
		  1 font-lock-warning-face t))))

;; show the name of the current function definition in the modeline
(require 'which-func)
(which-func-mode 1)

(defun prelude-prog-mode-hook ()
  "Default coding hook, useful with any programming language."
  (flyspell-prog-mode)
  (prelude-local-comment-auto-fill)
  (prelude-turn-on-abbrev)
  (prelude-add-watchwords)
  ;; keep the whitespace decent all the time
  (add-hook 'before-save-hook 'whitespace-cleanup nil t))

;; in Emacs 24 programming major modes generally derive
;; from a common mode named prog-mode
(add-hook 'prog-mode-hook 'prelude-prog-mode-hook)

(provide 'prelude-programming)
;;; prelude-programming.el ends here
