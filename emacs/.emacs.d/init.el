(setq load-path (cons "~/.emacs.d/vendor" load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
			("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
			("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; bootstrap 'use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; always install missing packages
(setq use-package-always-ensure t)

;; THEMES
(use-package zenburn-theme)
(use-package solarized-theme)
(use-package leuven-theme)
(use-package material-theme)
(use-package moe-theme)
(use-package gotham-theme)
(use-package gruvbox-theme)

;; EVIL
(use-package evil
  :config
  (evil-mode 1))

;; evil-leader
(use-package evil-leader
  :config
  (setq evil-leader/leader ",")
  (global-evil-leader-mode))

;; evil-powerline
(use-package powerline
  :config (powerline-evil-vim-color-theme))

;; evil-surround
(use-package evil-surround
  :defer t
  :config (global-evil-surround-mode t))

;; evil-tabs
(use-package evil-tabs
  :defer t
  :config (global-evil-tabs-mode t))

;; AVY
(use-package avy
  :defer t)

;; FLYCHECK
(use-package flycheck
  :defer t
  :config
  (global-flycheck-mode))

;; flycheck-pos-tip
(use-package flycheck-pos-tip
  :defer t
  :config
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode)))

;; RUBY
;;; rcodetools
(load "rcodetools")
(require 'rcodetools)
(defun auto-xmp ()
  "Add xmp comment and run xmp!"
  (interactive)
  (end-of-line)
  (insert " #=>")
  (xmp))

;; enh-ruby-mode
(use-package enh-ruby-mode
  :defer t
  :config
  :mode ("\\.rb\\'" "\\.ru\\'" "\\.rake\\'" "\\.thor\\'" "\\.jbuilder\\'" "\\.gemspec\\'" "\\.podspec\\'" "\\.Gemfile\\'" "\\.Rakefile\\'" "\\.Capfile\\'" "\\.Thorfile\\'" "\\.Vagrantfile\\'" "\\.Guardfile\\'" "\\.Podfile\\'"))

;; ruby-refactor
(use-package ruby-refactor
  :defer t
  :config
  (add-hook 'enh-ruby-mode-hook 'ruby-refactor-mode-launch))

;; HELM
(use-package helm
  :defer t
  :config
    (require 'helm-config)
    (helm-mode 1)
    (define-key helm-find-files-map "\t" 'helm-execute-persistent-action))

;; MAGIT
(use-package magit
  :defer t
  :config
  (require 'evil-magit)
  (setq evil-magit-state 'normal)
  (add-hook 'magit-mode-hook 'evil-local-mode)
  (add-hook 'git-rebase-mode-hook 'evil-local-mode))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; which-key
(use-package which-key
  :config (which-key-mode))

(use-package htmlize)

;; org-mode
(use-package org
  :defer t
  :config
  (org-babel-do-load-languages 'org-babel-load-languages
			       '((ruby . t)
				 (haskell . t)))
  (org-toggle-pretty-entities))

;; s.el, "emacs' long lost string manipulation library"
(use-package s)

;; smartparens
(use-package smartparens
  :config
  (require 'smartparens-config)
  (add-hook 'prog-mode-hook #'smartparens-mode))

;; projectile
(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t)
  (setq projectile-mode-line "Projectile"))
(use-package helm-projectile)

;; haskell
(use-package haskell-mode)

;; spreadsheet
(use-package csv-mode
  :defer t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CUSTOM FUNCTIONS

;; evil related:
(defun nmap (trigger action)
  (define-key evil-normal-state-map (kbd trigger) action))
(defun vmap (trigger action)
  (define-key evil-visual-state-map (kbd trigger) action))
;;; evil-leader 'lamdas', turned into functions to play nice with emacs
(defun load-dot-emacs ()
  "loads ~/.emacs.d/init.el"
  (interactive)
  (load-file "~/.emacs.d/init.el"))
(defun launch-term ()
  "launches a zsh term"
  (interactive)
  (term "/bin/zsh"))

(defun hours-matches (text)
  "return list of /\s\d\d:\d\d\s/ matches of text."
  (let ((timestamp-regexp "[[:space:]]\\([[:digit:]][[:digit:]]:[[:digit:]][[:digit:]]\\)[[:space:]]?"))
    (thread-last (s-match-strings-all timestamp-regexp text)
      (mapcar (lambda (e) (car (last e))))
      (mapcar 's-trim))
    ))

(defun hours-s-to-int-list (hours-s)
  "Takes an hours string, returns '(hours-int minutes-int)"
  (mapcar 'string-to-int (s-split ":" hours-s)))

(defun calc-ts-diff (first-ts second-ts)
  "returns diff between 2 hh:mm format timestamps as string"
  (let* ((times (mapcar 'hours-s-to-int-list (list first-ts second-ts))) ; ((hours minutes) (hours minutes))
	 (minutes (- (nth 1 (nth 1 times)) (nth 1 (nth 0 times)))) ; doesn't take into account 60 cap?
	 (hours (-
		 (- (car (nth 1 times)) (car (nth 0 times)))
		 (if (< minutes 0) 1 0))))
    (format "%d:%02d" hours (if (< minutes 0) (+ 60 minutes) minutes))
    ))
  
(defun append-line-hour-total ()
  "Calculate the difference between two hh:mm timestamps on current line and append ' | Total: <diffhh:diffmm>'"
  (interactive)
  (let ((matches (hours-matches (thing-at-point 'line t))))
    (if (= 2 (length matches))
	(progn
	  (end-of-line)
	  (insert (format " | Total: %s" (apply 'calc-ts-diff matches))))
      (message (format "Wrong number of hour timestamps! Expected 2, got %d" (length matches))) ; will report 1 with '(nil)
    )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAPPINGS

;; global
(global-set-key (kbd "M-x") 'helm-M-x)
(windmove-default-keybindings)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cl" 'org-store-link)

;; evil-leader bindings
;; TODO: change lamdas to custom F() so they play nice with helm/errors
;; TODO: Consolidate specific file bindings with bookmarks
(evil-leader/set-key
  "," 'save-buffer
  "." 'other-window
  "E" 'load-dot-emacs
  "z" 'suspend-emacs
  "x" 'helm-M-x
  "w" evil-window-map
  "<return>" 'align-regexp
  "b" 'helm-buffers-list
  "B" 'helm-bookmarks
  "R" 'helm-recentf
  "k" 'helm-show-kill-ring
  "f" 'helm-find-files
  "t" 'launch-term
  "T" 'text-scale-adjust
  "<up>" 'enlarge-window
  "<down>" 'shrink-window
  "<left>" 'shrink-window-horizontally
  "<right>"  'enlarge-window-horizontally
  "gs" 'magit-status
  "pp" 'projectile-switch-project
  "pf" 'projectile-find-file
  "ph" 'helm-projectile
  )

(nmap "H" (kbd "g^"))
(nmap "L" (kbd "g_"))
(vmap "H" (kbd "g^"))
(vmap "L" (kbd "g_"))
(nmap "SPC" 'avy-goto-char)
(vmap "SPC" 'avy-goto-char)
(nmap "#" 'comment-line)
(vmap "#" 'comment-dwim)
(nmap "Y" (kbd "y$"))

;;; mode specific
;;;; ruby
(evil-leader/set-key-for-mode 'enh-ruby-mode
  "rm" 'ruby-refactor-extract-to-method
  "rv" 'ruby-refactor-extract-local-variable
  "rp" 'ruby-refactor-convert-post-conditional
  "#" 'auto-xmp)

;;;; lisp interaction
(evil-leader/set-key-for-mode 'lisp-interaction-mode
  "e" 'eval-defun
  )

;;;; org mode
(evil-leader/set-key-for-mode 'org-mode
  "o" (lambda () (interactive) (end-of-line) (org-meta-return)))

;;;; smartparens
(evil-leader/set-key-for-mode 'smartparens-mode ; this doesn't work for some reason?
  "s" 'sp-forward-slurp-sexp
  "S" 'sp-backward-slurp-sexp
  "l" 'sp-forward-barf-sexp
  "L" 'sp-backward-barf-sexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SETTINGS

(add-hook 'prog-mode-hook 'linum-mode)		; add line numbers for prog and text files
(add-hook 'text-mode-hook 'linum-mode)
(setq linum-format "%4d ")			; nicer line number format
(toggle-scroll-bar -1)				; remove gui scrollbars
(menu-bar-mode -1)				; remove gui menu bar
(tool-bar-mode -1)				; remove gui menu bar
(setq ring-bell-function 'ignore)		; Disable annoying bell sound
(setq auto-save-default nil)			; disable #auto-save-files#
(setq make-backup-files nil)			; disabel backupfiles~
(setq tramp-default-method "ssh")		; use ssh by default for tramp
(put 'dired-find-alternate-file 'disabled nil)	; re-enable a command in dired
(setq org-hide-leading-stars t)			; only show last star and good indent
(recentf-mode 1)				; enable recent file tracking
(setq recentf-max-menu-items 25)		; limit to 25
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
(setq org-agenda-files '("~/Org/inbox.org"
                         "~/Org/active.org"
                         "~/Org/tickler.org"))
(setq org-refile-targets '(("~/Org/active.org" :maxlevel . 3)
                           ("~/Org/someday.org" :maxlevel . 1)
                           ("~/Org/tickler.org" :maxlevel . 2)))
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/Org/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/Org/tickler.org" "Tickler")
                               "* %i%? \n %U")))
(setq org-agenda-span 14)			; change agenda display period to two weeks
(advice-add 'org-refile :after			; advise to save org buffers after refile
        (lambda (&rest _)
        (org-save-all-org-buffers)))
(setq initial-buffer-choice "~/Org/active.org") ; startup buffer set to active org file
(setq explicit-shell-file-name "/bin/bash") ; set shell-file-name to /bin/bash always, cures projectile/tramp find-file issue

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MISC FIXES

;;; esc quits EVERYTHING
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f36b0a4ecb6151c0ec4d51d5cafc94de326b4659aaa7ac64a663e38ebc6d71dc" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" default)))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (gotham-theme moe-theme htmlize csv-mode haskell-mode helm-projectile projectile evil-org smartparens-config smartparens use-package magit evil-magit flycheck-pos-tip helm evil-tabs enh-ruby-mode rcodetools flycheck powerline powerline-evil evil-powerline evil-surround zenburn-theme avy evil-leader))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; supposed to help with passphrase hanging issue
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
