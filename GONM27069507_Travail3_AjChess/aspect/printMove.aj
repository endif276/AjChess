package ca.uqac.inf957.chess.aspect;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import ca.uqac.inf957.chess.Board;
import ca.uqac.inf957.chess.agent.Move;
import ca.uqac.inf957.chess.agent.Player;

public aspect printMove {
	
	
	/*
	 * 
	 * 
	 * Déclaration des pointcuts
	 * 
	 * 
	 */
	
	
	pointcut BoardMovePiece(Board b, Move mv) : 
		target(b)
		&& execution(void Board.movePiece(Move))
		&& args(mv);
	

	/*
	 * 
	 * 
	 * Déclaration des advices
	 * 
	 * 
	 */
	
	
	after(Board b, Move mv):BoardMovePiece( b, mv){
		
		/*
		 * 
		 * 
		 * Ajoute des instructions après l'exécution de la méthode void Board.movePiece(Move) 
		 * 
		 * 
		 */
		
		
		FileWriter fw;


				try {
					fw = new FileWriter("Deplacements.txt",true);
					fw.write("");
					String pName = b.getGrid()[mv.xF][mv.yF].getPiece().getClass().getName();
					pName=pName.substring(pName.indexOf("piece")+6);
					
					switch(b.getGrid()[mv.xF][mv.yF].getPiece().getPlayer()) 
					{
					
					case Player.BLACK :

						fw.write("Black " +pName+ " : " + mv.toString()+"");
						fw.write("\r\n");
						fw.flush();
						break;
					case Player.WHITE :
	
						fw.write("White " +pName+ " : " + mv.toString()+"");
						fw.write("\r\n");
						fw.flush();
						break;
					
					}
					
					fw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					
					e.printStackTrace();
				}
				

		
		
	}
	
	
	
}
