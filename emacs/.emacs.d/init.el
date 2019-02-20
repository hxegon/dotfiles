(package-initialize)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("5f27195e3f4b85ac50c1e2fac080f0dd6535440891c54fcfa62cdcefedf56b1b" "84890723510d225c45aaff941a7e201606a48b973f0121cb9bcb0b9399be8cba" default)))
 '(eshell-destroy-buffer-when-process-dies t)
 '(eshell-ls-use-colors t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (ace-window monokai-theme yaml-mode flycheck magit exec-path-from-shell lua-mode which-key zenburn-theme ace-jump-mode)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "nil" :family "Mononoki")))))

;; START MANUAL CONFIG
(add-to-list 'load-path "~/.emacs.d/vendor")

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(defun run-server ()
  "Run the Emacs server if it isn't running."
  (require 'server)
  (unless (server-running-p)
    (server-start)))

(run-server) ; This ensures that emacsclient will work even when there's no running server

;; Change default set-mark-command binding (C-SPC) to C-return
;; so it doesn't shadow the global quick add command from things app
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "<C-return>") 'set-mark-command)

;; Global modes
(which-key-mode)
(ido-mode)

;; Local modes
(add-hook 'prog-mode-hook 'linum-mode)

;; Global keys
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "M-p") 'ace-window) ;; doesn't work in Eshell
(define-key global-map (kbd "C-x C-b") 'ibuffer)

;; Fix some backup/autosave behaviour, save in ~/.emacs-saves
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.emacs.d/saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/saves" t)))

;; ESHELL
;; https://www.youtube.com/watch?v=RhYNu6i_uY4&t=2162s
;; Above shows how to fix eshell not working with special display programs
;; such as git diff
(require 'em-term) ; eshell-visual vars don't exist without this loading first
(add-to-list 'eshell-visual-subcommands
	     '("git" "log" "diff" "show"))

;; RECENTF
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; MAGIT
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; FLYCHECK
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; RUBY
;; -> CHRUBY
(require 'chruby) ; TODO: Add to package manager whenever that's figured out
(chruby-use "ruby-2.5.3")
