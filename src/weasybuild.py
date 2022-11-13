from weasyprint import HTML
document = HTML('docs/RULES.html').render()
document.write_pdf('_output/RULES.pdf')