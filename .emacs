;;; .emacs --- GNU Emacs configuration file

;;; Commentary:
;;  GNU Emacs general configuration
;;;

;;; Code:
(require 'bs)
(require 'org)
(require 'cl-lib)
(require 'package)

(setq-default major-mode 'text-mode)

(require 'dired)
(setq-default dired-recursive-deletes 'top)

(tooltip-mode        -1)
(menu-bar-mode       -1)
(tool-bar-mode       -1)
(auto-fill-mode      -1)
(scroll-bar-mode     -1)
(global-hl-line-mode -1)

(delete-selection-mode)
(setq-default show-paren-delay 0
              show-paren-style 'parenthesis)

(show-paren-mode)
(column-number-mode)
(size-indication-mode)
(setq-default truncate-lines t
              global-visual-line-mode nil
              truncate-partial-width-windows nil)

(setq-default search-highlight t
              query-replace-highlight t)

(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default use-dialog-box nil)

(setq-default inhibit-startup-screen t
              initial-scratch-message "")

(display-time-mode)
(setq-default display-time-24hr-format t)
(setq-default ring-bell-function 'ignore)

(setq-default indicate-empty-lines t
              indicate-buffer-boundaries 'left)

(setq-default frame-title-format "%b")

(savehist-mode)
(save-place-mode)
(setq-default history-length 1000
              history-delete-duplicates t
              savehist-save-minibuffer-history t)

(setq-default version-control        t
              auto-save-default      t
              backup-by-copying      t
              kept-new-versions      3
              kept-old-versions      1
              make-backup-files      t
              delete-old-versions    t
              vc-make-backup-files   t
              backup-directory-alist '(("." . "~/.emacs.d/backups")))

(require 'ido)
(require 'imenu)
(require 'ibuffer)
(ido-mode t)
(ido-everywhere)
(icomplete-mode)
(defalias 'list-buffers 'ibuffer)
(setq-default imenu-auto-rescan t
              imenu-use-popup-menu nil)
(setq-default ido-enable-flex-matching t)

(require 'font-lock)
(global-font-lock-mode)
(setq-default font-lock-maximum-decoration t)

(electric-indent-mode)
(electric-pair-mode -1)

(defalias 'perl-mode 'cperl-mode)
(setq-default cperl-indent-level 4)
(setq-default tab-width 4
              standard-indent 4
              indent-tabs-mode nil
              tab-always-indent 'complete)
(setq-default c-basic-offset 4
              c-default-style "bsd")
(add-hook 'c-mode-common-hook
          '(lambda () (c-toggle-auto-newline)))
(setq-default python-indent 4
              python-indent-offset 4
              python-indent-guess-indent-offset nil)
(add-hook 'makefile-mode-hook
          '(lambda () (setq-default indent-tabs-mode t)))
(setq-default lisp-body-indent 4
              lisp-indent-function 'common-lisp-indent-function)

(setq-default scroll-step 1
              scroll-margin 10
              redisplay-dont-pause t
              mouse-wheel-follow-mouse t
              scroll-conservatively 10000
              mouse-wheel-progressive-speed nil
              mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(global-auto-revert-mode)
(setq-default require-final-newline t
              next-line-add-newlines nil
              sentence-end-double-space nil)

(prefer-coding-system                   'utf-8)
(set-language-environment               'UTF-8)
(set-keyboard-coding-system             'utf-8-unix)
(set-terminal-coding-system             'utf-8)
(set-selection-coding-system            'utf-8)
(setq-default coding-system-for-read    'utf-8
              file-name-coding-system   'utf-8
              buffer-file-coding-system 'utf-8)

(require 'cedet)
(require 'cc-mode)
(require 'semantic)
(require 'ede/generic)
(require 'semantic/ia)
(require 'semantic/bovine/gcc)
(defvar *semantic-modes*
  (list 'global-semanticdb-minor-mode
        'global-semantic-decoration-mode
        'global-semantic-mru-bookmark-mode
        'global-semantic-highlight-func-mode
        'global-semantic-idle-scheduler-mode
        'global-semantic-idle-completions-mode
        'global-semantic-show-parser-state-mode))
(dolist (mode *semantic-modes*)
    (add-to-list 'semantic-default-submodes mode))
(semantic-mode)
(global-ede-mode)
(ede-enable-generic-projects)

(setq-default abbrev-mode t
              save-abbrevs 'silent)

(require 'bookmark)
(setq-default bookmark-save-flag t)
(if (file-exists-p (concat user-emacs-directory "bookmarks"))
    (bookmark-load bookmark-default-file t))

(defun format-buffer ()
    "Buffer formatting: DTW, tabify/untabify, indent."
    (save-excursion
     (recenter)
     (delete-trailing-whitespace)
     (if (equal major-mode 'makefile-gmake-mode)
         (tabify (point-min) (point-max))
         (untabify (point-min) (point-max)))
     (unless (or (equal major-mode 'python-mode)
                 (equal major-mode 'makefile-gmake-mode))
         (indent-region (point-min) (point-max) nil))))
(add-hook 'before-save-hook 'format-buffer)

(global-unset-key [up])
(global-unset-key [down])
(global-unset-key [left])
(global-unset-key [right])
(windmove-default-keybindings)
(global-set-key (kbd "<f1>")  'speedbar)
(global-set-key (kbd "<f2>")  'ibuffer)
(global-set-key (kbd "<f3>")  'comment-line)
(global-set-key (kbd "<f4>")  'bookmark-set)
(global-set-key (kbd "<f5>")  'bookmark-jump)
(global-set-key (kbd "<f6>")  'bookmark-bmenu-list)
(global-set-key (kbd "<f7>")  'kmacro-start-macro)
(global-set-key (kbd "<f8>")  'kmacro-end-macro)
(global-set-key (kbd "<f9>")  'kmacro-call-macro)
(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)

(setq-default browse-url-browser-function 'browse-url-default-browser)

(when (not (memq system-type '(windows-nt ms-dos)))
    (add-to-list 'package-archives
                 '("melpa-stable" . "https://stable.melpa.org/packages/") t)
    (package-initialize)
    (setq-default package-check-signature nil)
    (load "~/.emacs_packages.el"))

(when (display-graphic-p)
    (require 'linum)
    (line-number-mode)
    (blink-cursor-mode)
    (global-linum-mode)
    (fringe-mode '(10 . 10))
    (setq-default cursor-type 'hollow)
    (setq-default linum-format "%5d ")
    (if (not (memq system-type '(windows-nt ms-dos)))
        (load-theme 'dracula t)
        (load-theme 'misterioso t))
    (add-to-list 'default-frame-alist '(top . 40))
    (add-to-list 'default-frame-alist '(left . 40))
    (add-to-list 'default-frame-alist '(width . 120))
    (add-to-list 'default-frame-alist '(height . 40)))

;;; .emacs ends here
