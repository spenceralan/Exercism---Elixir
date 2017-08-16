defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """

  @orbital_periods %{
    earth: 1,
    mercury: 0.2408467,
    venus: 0.61519726,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132,
  }

  @seconds_per_year 31557600

  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds / (Map.get(@orbital_periods, planet) * @seconds_per_year)
  end
end
