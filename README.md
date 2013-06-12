Forms Plugin for Wheelhouse CMS
===============================

![Screenshot of forms plugin](https://www.wheelhousecms.com/media/cdfaf962/Forms-Plugin.png)

This gem makes it easy to add customizable forms (such as contact forms) into your [Wheelhouse CMS](https://www.wheelhousecms.com/) site, via an easy-to-use form builder. Form submissions are saved within the CMS and may optionally be emailed to one or more recipients.

The following field types are supported:

 - single-line text (with HTML5 input types)
 - text areas
 - select/dropdown box
 - single checkboxes
 - checkbox set
 - radio button set
 - US/Australian states dropdown
 - countries dropdown
 - HTML content
 - custom fields
 - nesting within field sets

Other features include:

 - server-side and HTML5 form validation
 - CSV export of submissions
 - optional spam filtering (via Akismet)


Installation & Usage
--------------------

**1. Add `wheelhouse-forms` to your Gemfile:**

    gem "wheelhouse-forms"

Then run `bundle install`.

**2. Create a new form from the New Page dropdown.**

**3. To customize, copy the `form.html.haml` template from `app/templates` to your theme templates folder.**


### Spam Filtering with Akismet

Spam filtering support requires an Akismet API key. Sign up for one at <https://akismet.com/signup/>.

**1. Add `rakismet` to your Gemfile:**

    gem "rakismet"
    
Then run `bundle install`.

**2. Add your Akismet API key and web site URL to `config/application.rb`.**

    config.rakismet.key = "1234abcd1234"
    config.rakismet.url = "http://www.example.com/"

**3. Restart your Rails server. The forms plugin will automatically use Rakismet if it is configured.**
