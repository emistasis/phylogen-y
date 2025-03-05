"""
Script title: phyloP_FASTA_annotator.py
Author: Emmarie Alexander
Date written: 08-January-2025
Date last updated: 09-January-2025
Purpose: This CLI python-based script allows users to annotate their FASTA file with phyloP scores and then filter sites based on a user provided threshold to create a new FASTA file.
Note: I have provided the environment file to run this script - the YML is called phyloP_env.yml
"""
import argparse
import os
import csv
import logging
import matplotlib.pyplot as plt

# Set-up the log file
def setup_logger(log_file):
    """Set up the logger to write to both a log file and the console."""
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
        handlers=[
            logging.FileHandler(log_file),
            logging.StreamHandler()
        ]
    )


# Configure output directory
def ensure_output_dir_exists(output_dir):
    """Ensure the output directory does indeed exist, create it if it does not."""
    if not os.path.exists(output_dir):
        logging.info(f"Creating output directory: {output_dir}")
        os.makedirs(output_dir)


def parse_fasta(fasta_file):
    """Parse FASTA file and convert it to a tabular format."""
    logging.info(f"Parsing FASTA file: {fasta_file}")
    try:
        with open(fasta_file, 'r') as f:
            species_names = []
            sequences = []
            # Read the FASTA line by line
            current_sequence = []
            for line in f:
                line = line.strip()
                if line.startswith(">"):
                    species_names.append(line[1:])  # Get species name
                    if current_sequence:
                        sequences.append("".join(current_sequence))
                        current_sequence = []
                else:
                    current_sequence.append(line)
            if current_sequence:
                sequences.append("".join(current_sequence))
        # Transpose sequences to create a base-by-base table
        alignment_matrix = [list(seq) for seq in zip(*sequences)]
        logging.info(f"Successfully parsed FASTA file: {len(species_names)} species, {len(alignment_matrix)} alignment positions.")
        return species_names, alignment_matrix
    except Exception as e:
        logging.error(f"Error parsing FASTA file: {e}")
        raise


def read_phyloP_scores(phyloP_file):
    """Read the phyloP scores from a file."""
    logging.info(f"Reading phyloP scores file: {phyloP_file}")
    try:
        with open(phyloP_file, 'r') as f:
            scores = [float(line.strip()) for line in f if line.strip()]  # Skip empty lines
        logging.info(f"Total phyloP scores: {len(scores)}")
        logging.info(f"Min phyloP score: {min(scores)}, Max phyloP score: {max(scores)}")
        return scores
    except Exception as e:
        logging.error(f"Error reading phyloP scores file: {e}")
        raise


def count_scores_in_range(scores, score_range):
    """Count the number of scores within a given range."""
    count = sum(score_range[0] <= score <= score_range[1] for score in scores)
    logging.info(f"Range {score_range}: Counted {count} scores")
    return count
    

def write_summary_file(output_dir, conserved_count, conserved_range, neutral_count, neutral_range, accelerated_count, accelerated_range):
    """Write a summary file with the counts of scores in each range."""
    summary_file = os.path.join(output_dir, "score_summary.txt")
    logging.info(f"Writing summary file: {summary_file}")
    try:
        with open(summary_file, 'w') as f:
            f.write("PhyloP Score Summary\n")
            f.write("====================\n")
            f.write(f"Conserved range: {conserved_range[0]} to {conserved_range[1]}\n")
            f.write(f"Conserved count: {conserved_count}\n\n")
            f.write(f"Neutral range: {neutral_range[0]} to {neutral_range[1]}\n")
            f.write(f"Neutral count: {neutral_count}\n\n")
            f.write(f"Accelerated range: {accelerated_range[0]} to {accelerated_range[1]}\n")
            f.write(f"Accelerated count: {accelerated_count}\n")
        logging.info(f"Summary file written successfully: {summary_file}")
    except Exception as e:
        logging.error(f"Error writing summary file: {e}")
        raise

def write_csv(file_path, species_names, alignment_matrix, phyloP_scores):
    """Write alignment and phyloP scores to a CSV file."""
    logging.info(f"Writing CSV file: {file_path}")
    try:
        with open(file_path, 'w', newline='') as f:
            writer = csv.writer(f, delimiter=',')
            # Write header
            writer.writerow(species_names + ["phyloP"])
            # Write rows
            for row, score in zip(alignment_matrix, phyloP_scores):
                writer.writerow(row + [score])
        logging.info(f"Successfully wrote CSV file: {file_path}")
    except Exception as e:
        logging.error(f"Error writing CSV file: {e}")
        raise

def write_fasta(file_path, species_names, alignment_matrix):
    """Write alignment back to FASTA format."""
    logging.info(f"Writing FASTA file: {file_path}")
    try:
        with open(file_path, 'w') as f:
            for i, species in enumerate(species_names):
                f.write(f">{species}\n")
                f.write("".join(row[i] for row in alignment_matrix) + "\n")
        logging.info(f"Successfully wrote FASTA file: {file_path}")
    except Exception as e:
      logging

def plot_phyloP_distribution(phyloP_scores, conserved_range, neutral_range, accelerated_range, output_path=None):
    """Plot the distribution of phyloP scores with defined ranges and labels."""
    logging.info("Plotting phyloP score distribution.")
    try:
        plt.figure(figsize=(10, 6))
        plt.hist(phyloP_scores, bins=50, color='skyblue', edgecolor='black', alpha=0.7)

        # Highlight the ranges and count scores
        conserved_count = count_scores_in_range(phyloP_scores, conserved_range)
        neutral_count = count_scores_in_range(phyloP_scores, neutral_range)
        accelerated_count = count_scores_in_range(phyloP_scores, accelerated_range)

        # Add shaded regions and labels
        plt.axvspan(conserved_range[0], conserved_range[1], color='green', alpha=0.2, label=f"Conserved ({conserved_count})")
        plt.axvspan(neutral_range[0], neutral_range[1], color='blue', alpha=0.2, label=f"Neutral ({neutral_count})")
        plt.axvspan(accelerated_range[0], accelerated_range[1], color='red', alpha=0.2, label=f"Accelerated ({accelerated_count})")

        # Add labels and legend
        plt.title("PhyloP Score Distribution with Ranges")
        plt.xlabel("PhyloP Score")
        plt.ylabel("Frequency")
        plt.legend()

        if output_path:
            plt.savefig(output_path)
            logging.info(f"Saved phyloP distribution plot to {output_path}")
        else:
            plt.show()

        return conserved_count, neutral_count, accelerated_count
    except Exception as e:
        logging.error(f"Error plotting phyloP distribution: {e}")
        raise


def main(args):
    # Ensure the output directory exists
    ensure_output_dir_exists(args.output_dir)

    # Set up the logger to write to a file within the output directory
    log_file_path = os.path.join(args.output_dir, args.log_file or "script.log")
    setup_logger(log_file_path)

    logging.info("Starting script execution.")

    try:
        # Parse the FASTA file
        species_names, alignment_matrix = parse_fasta(args.fasta)

        # Read the phyloP scores
        phyloP_scores = read_phyloP_scores(args.phyloP)

        # Ensure the number of scores matches the alignment columns
        if len(alignment_matrix) != len(phyloP_scores):
            raise ValueError("Number of phyloP scores does not match the number of alignment positions!")

        # Plot phyloP distribution with ranges
        if args.plot:
            plot_path = os.path.join(args.output_dir, args.plot)

            conserved_count, neutral_count, accelerated_count = plot_phyloP_distribution(
                phyloP_scores,
                conserved_range=(args.conserved_min, args.conserved_max),
                neutral_range=(args.neutral_min, args.neutral_max),
                accelerated_range=(args.accelerated_min, args.accelerated_max),
                output_path=plot_path
            )
        else:
            # If no plot is requested, calculate counts directly
            conserved_count = count_scores_in_range(phyloP_scores, (args.conserved_min, args.conserved_max))
            neutral_count = count_scores_in_range(phyloP_scores, (args.neutral_min, args.neutral_max))
            accelerated_count = count_scores_in_range(phyloP_scores, (args.accelerated_min, args.accelerated_max))

            # Write the summary file with counts
            write_summary_file(
                conserved_count,
                (args.conserved_min, args.conserved_max),
                neutral_count,
                (args.neutral_min, args.neutral_max),
                accelerated_count,
                (args.accelerated_min, args.accelerated_max),
                args.output_dir
            )
        
         # Write pre-filtering CSV
        pre_filter_csv = os.path.join(args.output_dir, "alignment_pre_filter.csv")
        write_csv(pre_filter_csv, species_names, alignment_matrix, phyloP_scores)

         # Filter rows based on the phyloP threshold
        filtered_matrix = []
        filtered_scores = []
        for row, score in zip(alignment_matrix, phyloP_scores):
            if args.min_cutoff <= score <= args.max_cutoff:
                filtered_matrix.append(row)
                filtered_scores.append(score)

        # Write filtered CSV
        filtered_csv = os.path.join(args.output_dir, "alignment_filtered.csv")
        write_csv(filtered_csv, species_names, filtered_matrix, filtered_scores)
        
        # Write filtered FASTA
        filtered_fasta = os.path.join(args.output_dir, "alignment_filtered.fasta")
        write_fasta(filtered_fasta, species_names, filtered_matrix)

        logging.info("Script execution completed successfully.")

    except Exception as e:
        logging.error(f"Script execution failed: {e}")
        raise

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process and filter a FASTA alignment with phyloP scores.")
    parser.add_argument("--fasta", required=True, help="Path to the input FASTA file.")
    parser.add_argument("--phyloP", required=True, help="Path to the file containing phyloP scores.")
    parser.add_argument("--output_dir", required=True, help="Directory to save output files.")
    parser.add_argument("--plot", help="Path to save the phyloP score distribution plot (optional).")
    parser.add_argument("--log_file", default="script.log", help="Path to save the log file.")
    parser.add_argument("--min_cutoff", type=float, default="-0.5", help="Minimum phyloP score for filtering cutoff")
    parser.add_argument("--max_cutoff", type=float, default=0.5, help="Maximum phyloP score for filtering cutoff")

    # Define optional ranges for conserved, neutral, and accelerated sites
    parser.add_argument("--conserved_min", type=float, default=1.5, help="Minimum score for conserved sites (default: 1.5).")
    parser.add_argument("--conserved_max", type=float, default=3.0, help="Maximum score for conserved sites (default: 3.0).")
    parser.add_argument("--neutral_min", type=float, default=-0.5, help="Minimum score for neutral sites (default: -0.5).")
    parser.add_argument("--neutral_max", type=float, default=0.5, help="Maximum score for neutral sites (default: 0.5).")
    parser.add_argument("--accelerated_min", type=float, default=-3.0, help="Minimum score for accelerated sites (default: -3.0).")
    parser.add_argument("--accelerated_max", type=float, default=-1.5, help="Maximum score for accelerated sites (default: -1.5).")

    args = parser.parse_args()
    main(args)
