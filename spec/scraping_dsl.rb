require_relative 'spec_helper.rb'
require_relative '../lib/scrapeybara'


describe 'DSL' do
  describe '.string' do
    let :string do
      Capybara.string <<-STRING
        <div id="page">
          <div id="content">
            <h1 data="fantastic">Awesome</h1>
            <p>Yes it is</p>
          </div>

          <div id="footer" style="display: none">
            <p>c2010</p>
            <p>Jonas Nicklas</p>
            <input type="text" name="foo" value="bar"/>
            <select name="animal">
              <option>Monkey</option>
              <option selected="selected">Capybara</option>
            </select>
          </div>
        </div>
      STRING
    end

    it "allows using matchers" do
      string.should have_css('#page')
      string.should_not have_css('#does-not-exist')
    end

    it "allows using custom matchers" do
      Capybara.add_selector :lifeform do
        xpath { |name| "//option[contains(.,'#{name}')]" }
      end
      string.should have_selector(:page)
      string.should_not have_selector(:'does-not-exist')
      string.should have_selector(:lifeform, "Monkey")
      string.should_not have_selector(:lifeform, "Gorilla")
    end