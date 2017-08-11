defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """

  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    rna_chunks = rna_chunks(rna)
    if is_rna?(rna_chunks) do
      protein_list(rna_chunks)
    else
      {:error, "invalid RNA"}
    end
  end

  def protein_list(rna_chunks) do
    list = rna_chunks
    |> Enum.map( fn(x) ->
      {:ok, codon} = of_codon(x)
      codon
    end )
    |> Enum.reduce_while([], fn(x, acc) ->
      if x == "STOP" do
        {:halt, acc}
      else
        {:cont, [x | acc]}
      end
    end )
    |> Enum.reverse()
    {:ok, list}
  end

  def is_rna?(rna_chunks) do
    Enum.all?(rna_chunks, fn(chunk) ->
      {status, _} = of_codon(chunk)
      status == :ok
    end)
  end

  def rna_chunks(rna) do
    String.codepoints(rna)
    |> Enum.chunk_every(3)
    |> Enum.map( fn(x) -> Enum.join(x) end )
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    protein = Map.get(@proteins, codon)
    if protein do
      {:ok, protein}
    else
      {:error, "invalid codon"}
    end
  end
end

