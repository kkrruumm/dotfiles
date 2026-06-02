;;; init.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'config-core)
(require 'ui)
(require 'editing)
(require 'languages)
(require 'tools)
(require 'evil-settings)
(require 'keybind-settings)

;; ── restore GC to sane runtime values ───────────────────────────────
(setq gc-cons-threshold 100000000)      ; ~100 MB
(setq read-process-output-max 1048576)  ; 1 MB — helps LSP throughput

(provide 'init)
;;; init.el ends here
