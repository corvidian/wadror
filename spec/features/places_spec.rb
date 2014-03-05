require 'spec_helper'
require 'pp'

describe "places" do
  it "if none are returned by the API, a message is shown on the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end

  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
          [ Place.new(name:'Oljenkorsi', city:'Kumpula', id:1) ]
      )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'Oljenkorsi'
  end

  it 'if several are returned by the API, they are shown at the page' do
    BeermappingApi.stub(:places_in).with('kumpula').and_return(
        [ Place.new(:name => 'Oljenkorsi', city:'Kumpula',id:1), Place.new(:name => "Kumpulan Keidas", city:'Kumpula',id:2), Place.new(:name => "Gurulan salabaari", city:'Kumpula',id:3) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kumpulan Keidas"
    expect(page).to have_content "Gurulan salabaari"
  end
end