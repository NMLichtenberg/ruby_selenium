class BasePage

  def initialize(driver)
    @driver = driver
  end

  def text(locator)
    find(locator).text
  end

  def select_frame(frame)
    @driver.switch_to.frame frame
  end

  def title(title)
    @driver.title.should == title
  end

  def visit(url_path = '')
    @driver.get File.join(ENV['BASE_URL'], url_path)
  end

  def find(locator)
    @driver.find_element locator
  end

  def is_enabled?(locator)
    find(locator).enabled?
  end

  def enter
    @driver.action.key_down(:command)
    .send_keys('/n')
    .key_up(:command)
    .perform
  end

  def type(text, locator)
    find(locator).send_keys text
  end

  def submit(locator)
    find(locator).submit
  end

  def is_displayed?(locator)
    rescue_exceptions { find(locator).displayed? }
  end

  def is_not_displayed?(locator)
    rescue_exceptions { !find(locator).displayed? }
  end

  def wait_for(seconds = 120)
    Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }
  end

  def click(locator)
    find(locator).click
  end

  def select_from_list(element, text)
    list = find(element)
    options = list.find_elements(:tag_name => 'li')
    options.each do |item|
      if item.text == text
        item.click
        break
      end
    end
  end

  def verify_text(locator, content)
    rescue_exceptions { find(locator).text == content }
  end

  def clear(locator)
    find(locator).clear
  end

  def verify_regex_text(locator, content)
    rescue_exceptions { find(locator).text =~ content }
  end

  def maximize_browser
    @driver.manage.window.maximize
  end

  def rescue_exceptions
    begin
      yield
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      false
    end
  end

  def accept_alert
    popup = @driver.switch_to.alert
    popup.accept
  end

  def refresh
    @driver.navigate.refresh;
  end

  def resizeApplication(size)
    @driver.execute_script("window.resizeTo(#{size});")
  end

  def switch_to_new_window
    @driver.switch_to.window(@driver.window_handles.last)
  end
end
