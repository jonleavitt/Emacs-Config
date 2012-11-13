(setq geiser-racket-binary "/Users/Jon/Dropbox/programmingDropbox/bin/racket")

;; On OS X Emacs doesn't use the shell PATH if it's not started from
;; the shell. If you're using homebrew modifying the PATH is essential.
(if (eq system-type 'darwin)
        (push "/usr/local/bin" exec-path))

(defvar prelude-dir (file-name-directory load-file-name)
  "The root dir of the Emacs Prelude distribution.")
(defvar prelude-modules-dir (concat prelude-dir "modules/")
  "This directory houses all of the built-in Prelude module. You should
avoid modifying the configuration there.")
(defvar prelude-vendor-dir (concat prelude-dir "vendor/")
  "This directory house Emacs Lisp packages that are not yet available in
ELPA (or Marmalade).")
(defvar prelude-personal-dir (concat prelude-dir "personal/")
  "Users of Emacs Prelude are encouraged to keep their personal configuration
changes in this directory. All Emacs Lisp files there are loaded automatically
by Prelude.")

(add-to-list 'load-path prelude-modules-dir)
(add-to-list 'load-path prelude-vendor-dir)
(add-to-list 'load-path prelude-personal-dir)
(add-to-list 'load-path "elpa")
;; config changes made through the customize UI will be store here
(setq custom-file (concat prelude-personal-dir "custom.el"))

(require 'jon)
(require 'quack)
;; the core stuff
(require 'prelude-packages)
(require 'prelude-el-get)
(require 'prelude-ui)
(require 'prelude-core)
(require 'prelude-editor)
(require 'prelude-global-keybindings)

;; programming & markup languages support
(require 'prelude-programming)
(require 'prelude-c)
(require 'prelude-clojure)
(require 'prelude-coffee)
(require 'prelude-common-lisp)
(require 'prelude-emacs-lisp)
(require 'prelude-erc)
(require 'prelude-groovy)
(require 'prelude-haskell)
(require 'prelude-js)
(require 'prelude-markdown)
(require 'prelude-org)
(require 'prelude-perl)
(require 'prelude-python)
(require 'prelude-ruby)
(require 'prelude-scheme)
(require 'prelude-xml)

;; load the personal settings (this includes `custom-file')
(when (file-exists-p prelude-personal-dir)
  (mapc 'load (directory-files prelude-personal-dir nil "^[^#].*el$")))

;;; init.el ends here
(put 'upcase-region 'disabled nil)
(setq geiser-repl-use-other-window nil)
