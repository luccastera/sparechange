require 'rubygems'
require 'spec'

require File.dirname(__FILE__) + '/../lib/db'

# get("http://yahoo.com")
# get("http://yahoo.com")
# get "http://search.yahoo.com/search?p=rack"

describe "get_url method" do
  
  before(:each) do
    @db = Database.new
  end
  
  it "should ..." do
    result = @db.get_url "http://yahoo.com"
    result.should == nil
  end
  
end

describe "store method" do

  before(:each) do
    @db = Database.new
  end
  
  def yahoo_doc_parameters
    url = "http://yahoo.com"
    body = %W{
      <html>
        <body>
          <p>stuff</p>
        </body>
      </html>
    }
    retrieved_at = Time.now
    return [url, retrieved_at, body]
  end
  
  it "a fresh save should return true" do
    result = @db.store yahoo_doc_parameters
    result.should == true
  end
  
  it "an overwrite should return true" do
    result_1 = @db.store yahoo_doc_parameters
    result_1.should == true

    result_2 = @db.store yahoo_doc_parameters
    result_2.should == true
  end

  it "should raise an exception if CouchDB is not running" do
    lambda {
      result = @db.store yahoo_doc_parameters
    }.should_raise PersistenceStoreUnavailable
  end
  
end
