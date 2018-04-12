// 
class AffiliateForm {

  form() { return $("#affiliate-form") }

  button() { return this.form().find(".btn") }

  disableButton() { this.button().prop("disabled", true) }

  enableButton() { this.button().prop("disabled", false) }

  isEnabled() { return !this.button().prop("disabled") }

  isButtonDisabled() { return this.button().prop("disabled") }

  submit() { this.form().get(0).submit() }

  appendHidden(name, value) {
    const field = $("<input>")
      .attr("type", "hidden")
      .attr("name", name)
      .val(value)
    this.form().append(field)
  }

  appendError(message) {
    const field = $("<h2>").text(message)
    this.form().prepend(field)
  }
}
// 

// 
class AffiliateFormHandler {

  constructor() {
    this.affiliateForm = new AffiliateForm()
    this.initEventHandlers()
  }

  initEventHandlers() {
    this.affiliateForm.form().submit(event => {
      this.handleSubmit(event)
    })
  }

  handleSubmit(event) {
    event.preventDefault()
    if (this.affiliateForm.isButtonDisabled()) {
      return false
    }
    this.affiliateForm.disableButton()
    Stripe.bankAccount.createToken(
        this.affiliateForm.form(), BankAccountTokenHandler.handle)
    return false
  }
}
// 

// 
class BankAccountTokenHandler {
  static handle(status, response) {
    new BankAccountTokenHandler(status, response).handle()
  }

  constructor(status, response) {
    this.affiliateForm = new AffiliateForm()
    this.status = status
    this.response = response
  }

  isError() { return this.response.error }

  handle() {
    if (this.isError()) {
      this.affiliateForm.appendError(this.response.error.message)
      this.affiliateForm.enableButton()
    } else {
      this.affiliateForm.appendHidden(
          "account[external_account]", this.response.id)
      this.affiliateForm.submit()
    }
  }
}
// 

// 
$(() => {
  if ($(".bank_account_form").size() > 0) {
    return new AffiliateFormHandler()
  }
  return null
})
// 
