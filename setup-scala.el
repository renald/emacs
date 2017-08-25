;; Add the ENSIME plugin to sbt

;; addSbtPlugin("org.ensime" % "sbt-ensime" % "1.12.7") in ~/.sbt/0.13/plugins/plugins.sbt

(use-package ensime
  :ensure t
  :pin melpa)

(use-package sbt-mode
  :pin melpa)

(use-package scala-mode
  :pin melpa)

(require 'ensime)

(add-to-list 'exec-path "/usr/local/bin")

;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(provide 'setup-scala)
