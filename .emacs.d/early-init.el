;;; early-init.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; max GC threshold during startup, restored at the end of init.el
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 1.0)

;; strip chrome before the frame draws to avoid flicker
(menu-bar-mode -1)
;;(tool-bar-mode -1)

;; don't let emacs resize the terminal frame
(setq frame-inhibit-implied-resize t)

;;; early-init.el ends here
