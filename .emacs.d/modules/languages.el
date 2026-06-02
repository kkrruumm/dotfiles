;;; languages.el --- -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:

(unless (package-installed-p 'treesit-auto)
  (package-install 'treesit-auto))

;; explicitly map lua to its tree-sitter mode (lua highlighting is ass without treeshitter)
(add-to-list 'major-mode-remap-alist '(lua-mode . lua-ts-mode))

;; temporarily re-enable on a fresh install to pull grammars, then comment out
;;(use-package treesit-auto
;;  :custom
;;  (treesit-auto-install 'prompt)
;;  :config
;;  (treesit-auto-add-to-auto-mode-alist 'all)
;;  (global-treesit-auto-mode))

;; more aggressive syntax highlighting
(setq treesit-font-lock-level 4)

;; markdown-replacer-9000 (buy now!)
(use-package org
  :ensure nil
  :hook
  (org-mode . org-indent-mode)
  (org-mode . visual-line-mode)
  :config
  (setq org-startup-folded 'content
        org-startup-indented t
        org-src-fontify-natively t
        org-src-tab-acts-natively t))

(unless (package-installed-p 'go-mode)
  (package-install 'go-mode))

(unless (package-installed-p 'lua-mode)
  (package-install 'lua-mode))

(unless (package-installed-p 'nix-mode)
  (package-install 'nix-mode))

(defun fixtabs-go-mode-hook ()
  "Force 4-space soft tabs in go-mode."
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq go-tab-width 4))

(add-hook 'go-mode-hook 'fixtabs-go-mode-hook)

(provide 'languages)
;;; languages.el ends here
